require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'sqlite3'
require_relative './lib/connection'
require_relative './lib/tshirts'
require_relative './lib/purchases'

use Rack::Session::Pool, :cookie_only => false

secret_password = ''
json = ''
File.open('secret.json', 'r') do |f|
  f.each_line do |line|
    json << line
  end
end
json_hash = JSON.parse(json)
secret_password = json_hash['password']


def authenticated?
  session[:valid_user] == true
end


db = SQLite3::Database.new "tshirtstore.db"

after do
  ActiveRecord::Base.connection.close
end

put '/admin' do
  thisshirt = Tshirt.find_by({id: params["id"].to_i})

  thisshirt.quantity = params["quantity"]
  thisshirt.save

  redirect '/admin'
end

get '/' do
  erb :index, locals: {tshirts: Tshirt.all() }
end

post '/' do
  purchaseObj = {
    name: params["name"],
    email: params["email"],
    tshirt_id: params["tshirt_id"].to_i,
    quantity: params["quantity"].to_i
  }
  Purchase.create(purchaseObj)
  thisshirt = Tshirt.find_by({id: params["tshirt_id"].to_i})
  thisshirt.quantity = thisshirt.quantity - params["quantity"].to_i
  thisshirt.save
  erb :index, locals: {tshirts: Tshirt.all()}
  redirect '/'
end

get '/admin' do
  if authenticated?
    erb :admin, locals: {tshirts: Tshirt.all(), purchases: Purchase.all() }
  else
    redirect '/'
  end
end

post '/session' do
  if params[:password] === secret_password
    session[:valid_user] = true
    redirect '/admin'
  else
    redirect '/'
  end
end




# post '/admin' do
#   artist = {
#     name: params["name"],
#     price: 10,
#     quantity: ,
#     img_url:
#   };
#   Tshirt.create(tshirt)
#   erb :"artists/index", locals: {tshirt: Tshirt.all() }
# end

# put '/admin/:id' do
#   t_hash = {
#     quantity: params["quantity"]
#   }
#
#   tshirt = Tshirt.find_by({id: params[:id]})
#   tshirt.update(t_hash)
#
#   erb :admin, locals: {tshirts: tshirt}
#
# end


#

#
# get '/admin' do
#   artist = Artist.find_by({id: params[:id]})
#   erb :"artists/show", locals: {artist: artist}
# end
