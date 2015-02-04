require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/connection'
require_relative './lib/tshirts'
require_relative './lib/purchases'

require 'sqlite3'

db = SQLite3::Database.new "tshirtstore.db"

after do
  ActiveRecord::Base.connection.close
end

put '/admin' do
  tshirt = Tshirt.find_by(params[:id])
  tshirt.quantity = params["quantity"]
  tshirt.save
    erb :admin, locals: { tshirts: Tshirt.all() }
    # redirect '/admin'
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
  erb :admin, locals: {tshirts: Tshirt.all(), purchases: Purchase.all() }


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
