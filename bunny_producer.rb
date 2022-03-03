#!/usr/bin/env ruby

require 'bunny'

conn = Bunny.new
conn.start

channel = conn.create_channel
queue = channel.queue("tx_dashboard", :auto_delete => false, :durable => true)
exchange = channel.default_exchange

[1, 2, 3, 4, 5].each do |i|
  random_amount = rand(1000.00..3000.00)
  transaction = "{\"account\": \"123\", \"type\": \"deposit\", \"origin\": \"transfer\", \"concept\": \"Some snacks\", \"amount\": #{random_amount}, \"currency\": \"MXN\"}"

  exchange.publish(transaction, :routing_key => queue.name)
end

sleep 1.0
conn.close

