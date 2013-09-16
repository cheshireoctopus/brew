require 'sinatra'
require 'sinatra/reloader'
require 'active_support/all'
require 'active_record'

# AUTHENTICATION
require 'digest/sha2'

# FOR LOGGED-IN USER
enable :sessions

ActiveRecord::Base.establish_connection(
    :adapter => "postgresql",
    :host => "localhost",
    :username => "Chandler",
    :password => "",
    :database => "brew"
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(ENV['HEROKU_POSTGRESQL_NAVY_URL'] || 'postgres://localhost/brew')

require_relative './models/brewery'
require_relative './models/beer'


### Routes ###

# Index Page
get '/' do
  redirect '/home'
end

# Index Page of Breweries
get '/home' do
  @brew_list = Brewery.order("created_at DESC").all
  erb :home
end

# New Brewery Page
get "/brewery/new" do
  erb :new_brewery
end

# Create New Brewery
post "/brewery/new" do
  brewery = Brewery.new(params[:brewery])
  brewery.save
  redirect '/home'
end

# View Individual Brewery
get '/brewery/:id' do
  id = params[:id].to_i
  @brewery = Brewery.find(id)
  erb :brewery
end

# Edit Brewery
get '/brewery/:id/edit' do
  id = params[:id].to_i
  @brewery = Brewery.find(id)
  erb :edit_brewery
end

# Update Brewery
post '/brewery/:id' do
  id = params[:id].to_i
  brewery = Brewery.find(id)
  brewery.update_attributes(params[:brewery])
  redirect '/home'
end

# DELETE BREWERY
post '/brewery/:id/delete' do
  id = params[:id].to_i
  brewery = Brewery.find(id)
  brewery.destroy
  redirect '/home'
end

# GET NEW BEER
get '/brewery/:id/new_beer' do
  id = params[:id]
  @brewery = Brewery.find(id)
  erb :new_beer
end

# POST NEW BEER
post '/brewery/:id/new_beer' do
  id = params[:id].to_i
  brewery = Brewery.find(id)
  brewery.beers << Beer.new(params[:beer])
  redirect '/home'
end
