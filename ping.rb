require 'net/ping'
require 'colorize'

def ping url
  sum = 0
  bugs = 0
  5.times do
    from = Time.now
    pt = Net::Ping::External.new(url)
    if pt.ping 
      cost = Time.now - from
      sum = sum + cost * 1000
    else
      if bugs == 0
        puts "ping #{url}: #{pt.exception}".colorize( :yellow )
      end
      bugs = bugs + 1
    end
  end
  sum = (sum / 5).round
  outputs = "ping #{url} : #{sum}ms, failed: #{bugs}.times"
  if bugs == 0
    puts outputs.colorize( :green )
  elsif bugs > 1 and bugs < 5
    puts outputs.colorize( :yellow )
  elsif bugs == 5
    puts outputs.colorize( :red )
  end
end

class SwitchIp

  def go vpn_name
    turn_off vpn_name
    sleep 3
    turn_on vpn_name
  end

  def turn_on vpn_name
    system "/usr/bin/env osascript <<-EOF
        tell application \"System Events\"
          tell current location of network preferences
              set VPN to service \"#{vpn_name}\" -- your VPN name here
              if exists VPN then connect VPN
        end tell
      end tell
    EOF"

  end

  def turn_off vpn_name
    system "/usr/bin/env osascript <<-EOF
      tell application \"System Events\"
        tell current location of network preferences
              set VPN to service \"#{vpn_name}\" -- your VPN name here
              if exists VPN then disconnect VPN
        end tell
    end tell
   EOF"
  end

end

ping "www.baidu.com"
ping 'us1.vpnplease.com'
ping 'us2.vpnplease.com'
ping 'us3.vpnplease.com'
ping 'us4.vpnplease.com'
ping 'us5.vpnplease.com'
ping 'jp1.vpnplease.com'
ping 'jp2.vpnplease.com'
ping 'jp3.vpnplease.com'
ping 'sg1.vpnplease.com'
ping 'hk1.vpnplease.com'
ping 'hk2.vpnplease.com'
ping 'uk1.vpnplease.com'

puts "Which VPN would you like?"
vpn_name = gets.strip
puts "Connecting to #{vpn_name}......"
vpn = SwitchIp.new
vpn.go vpn_name
