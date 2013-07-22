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

ping "www.baidu.com"
ping 'us1.vpncloud.me'
ping 'us2.vpncloud.me'
ping 'us3.vpncloud.me'
ping 'jp1.vpncloud.me'
ping 'jp2.vpncloud.me'
ping 'jp3.vpncloud.me'
ping 'sg1.vpncloud.me'
ping 'uk1.vpncloud.me'