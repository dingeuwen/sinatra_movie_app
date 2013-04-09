require 'pry'
gem 'sinatra', '1.3.0'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'better_errors'
require 'json'
require 'open-uri'
require 'uri'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path("..",__FILE__)	
end


get '/' do
  erb :home
end

post '/search' do
  @title = params[:search_movie_entry]
  file = open("http://www.omdbapi.com/?s=#{URI.escape(@title)}")
  @results = JSON.load(file.read)
  erb :search_results
end

get '/search_results/:id' do
  @query = params[:id]
  file = open("http://www.omdbapi.com/?i=#{URI.escape(@query)}")
  @results = JSON.load(file.read)
  erb :search_specifics
end

