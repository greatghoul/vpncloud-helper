require 'net/ping'

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
      bugs = bugs + 1
      puts "ping #{url}: #{pt.exception}"
    end
  end
  sum = (sum / 5).round
  puts "ping #{url} : #{sum}ms, failed: #{bugs}.times"
end

ping "baidu.com"
ping 'us1.vpncloud.me'
ping 'us2.vpncloud.me'
ping 'us3.vpncloud.me'
ping 'jp1.vpncloud.me'
ping 'jp2.vpncloud.me'
ping 'jp3.vpncloud.me'
ping 'sg1.vpncloud.me'
ping 'uk1.vpncloud.me'