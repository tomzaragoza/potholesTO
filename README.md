potholesTO
==========

Project for trying out Ruby, Sinatra, and Redis.

Run get_potholes.rb to load all the service requests for potholes into Redis.

To do:
- Check for service request IDs and if they are the same ones, but different status. This is important as I might have to update the service request in Redis.
- Filter display by Date
- Automatic loading (and updating according to what I found out from the first Todo) of service requests into Redis.

