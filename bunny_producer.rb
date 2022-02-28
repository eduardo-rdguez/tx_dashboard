#!/usr/bin/env ruby

require 'bunny'

conn = Bunny.new
conn.start

channel = conn.create_channel
queue = channel.queue("tx_dashboard", :auto_delete => false, :durable => true)
exchange = channel.default_exchange

transaction = "{\"account\": \"251678\", \"type\": {\"withdraw\": \"deposit\"}, \"origin\": {\"counter\": \"transfer\"}, \"concept\": \"Some snacks\", \"amount\": 3671.21, \"currency\": \"MXN\""

[1, 2, 3, 4, 5].each do |i|
  exchange.publish(transaction, :routing_key => queue.name)
end

sleep 1.0
conn.close

