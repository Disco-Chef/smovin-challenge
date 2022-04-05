require 'sinatra'
require 'sinatra/reloader' if development?
require 'byebug'
require_relative './services/indexator.rb'
require_relative './services/request_body_parameter_validator.rb'

post '/v1/indexations' do

  request_body = JSON.parse(request.body.read)

  # TK: Check for bad params. If so, respond with status 400 with errors for each input in the response body
  user_input_validator = RequestBodyParameterValidator.new(request_body)
  if user_input_validator.errors?
    response.status = 400
    return user_input_validator.errors.to_json
  end

  # TK: Use parsed body to do the calls to the indexation endpoint => Indexator.new.call(region, rent, signed_on, start_on)
  signed_on = Date.parse(request_body['signed_on'])
  start_date = Date.parse(request_body['start_date'])
  base_rent = request_body['base_rent']
  region = request_body['region']

  response.status = 200
  return Indexator.new.compute_new_rent(base_rent, region, signed_on, start_date).to_json
end

# TK: Accept: application/json in config? Also, all of this below into separate file..
configure do
  enable :cross_origin
end

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
end

options '*' do
  response.headers['Allow'] = 'POST, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Accept'
  response.headers['Access-Control-Allow-Origin'] = '*'
  200
end
