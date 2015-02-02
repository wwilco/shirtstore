require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/connection'
require_relative './lib/tshirts'
require_relative './lib/purchases'
require_relative './lib/customers'

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  erb :index, locals: {tshirts: Tshirt.all() }
end

get '/admin' do
  erb :admin, locals: {tshirts: Tshirt.all() }

end

#
# post '/admin' do
# artist = {
#   name: params["name"]
# };
# Tshirt.create(tshirt)
# erb :"artists/index", locals: {tshirt: Tshirt.all() }
# end
#
# get '/admin' do
#   artist = Artist.find_by({id: params[:id]})
#   erb :"artists/show", locals: {artist: artist}
# end
