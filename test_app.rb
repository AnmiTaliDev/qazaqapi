#!/usr/bin/env ruby

require 'net/http'
require 'json'

puts "Testing Kazakh API..."

# Health check
puts "\n1. Health check"
response = Net::HTTP.get_response(URI('http://localhost:4567/health'))
puts response.code == '200' ? "OK" : "FAIL"

# Main page
puts "\n2. Main page"
response = Net::HTTP.get_response(URI('http://localhost:4567/'))
puts response.code == '200' ? "OK" : "FAIL"

# Transliteration
puts "\n3. Transliteration test"
uri = URI('http://localhost:4567/transliterate')
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri)
request['Content-Type'] = 'application/json'
request.body = { text: 'Сәлем әлем' }.to_json

response = http.request(request)
if response.code == '200'
  data = JSON.parse(response.body)
  puts "Result: #{data['transliterated']}"
  puts data['transliterated'] == 'Sälem älem' ? "OK" : "FAIL"
else
  puts "FAIL (#{response.code})"
end

puts "\nDone."