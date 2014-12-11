# potholesTO.rb

require 'sinatra'
require 'httparty'
require 'pp'
require 'json'
require 'redis'

redis = Redis.new
service_requests_list = "service_requests_list"

get '/' do
	erb :map
end

get '/test' do
	l = [1,2,3]
	erb :test, :locals =>{:l=> l}
end

get '/map' do
	erb :map
end

get '/potholes' do
	service_requests = []
	ids = redis.smembers(service_requests_list)
	ids.each {|elem| service_requests << redis.hgetall(elem)}

	content_type :json
	{ :potholes=> service_requests}.to_json

	# puts service_requests
	# erb :map, :locals => {:potholes => service_requests}
end
