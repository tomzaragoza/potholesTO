
require 'redis'
require 'httparty'

redis = Redis.new
service_requests_list = "service_requests_list"

puts "Getting pothole requests from Toronto..."
response = HTTParty.get('https://secure.toronto.ca/webwizard/ws/requests.json?start_date=2014-01-01T00:00:00Z&end_date=2014-04-20T00:00:00Z&service_code=CSROWR-12&jurisdiction_id=toronto.ca')
response = response['service_requests']

puts "Loading pothole requets into Redis..."
response.each do |item|
	if !redis.smembers(service_requests_list).include? item['service_request_id']
		redis.sadd(service_requests_list, item['service_request_id'])

		redis.hset(item['service_request_id'], 'status', item['status'])
		redis.hset(item['service_request_id'], 'service_name', item['service_name'])
		redis.hset(item['service_request_id'], 'long', item['long'])
		redis.hset(item['service_request_id'], 'lat', item['lat'])
		redis.hset(item['service_request_id'], 'address', item['address'])
	elsif redis.smembers(service_requests_list).include? item['service_request_id']

		redis.hset(item['service_request_id'], 'status', item['status']) # should be a new status ie opened -> closed
		redis.hset(item['service_request_id'], 'service_name', item['service_name'])
	end
end
