require 'sinatra'

post 'v1/indexations' do
  # TK: Parse body into Date instances etc

  # TK: Check for bad params. If so, respond with status 400 with errors for each input in the response body

  # TK: Else, use objects from parsed body to do the calls to the indexation endpoint => Indexator.new.call(region, rent, signed_on, start_on)

  # TK: Respond with status 200 and response body with the new_rent, base_index, current_index
en

configure do
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

options '*' do
  response.headers['Allow'] = 'GET, PUT, POST, DELETE, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token'
  response.headers['Access-Control-Allow-Origin'] = '*'
  200
end
