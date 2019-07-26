require 'sinatra'
require 'sinatra/reloader'

# get '/' do
#     'Hello world'
# end


get '/' do
    @title = "My Site"
    erb :index
end


get '/about' do
    @title = "about this site"
    erb :about
end


get '/register' do
    erb :register
end


get '/login' do
    erb :login
end



# app.rb
get '/form' do
    erb :form
end



post '/form_output' do
    @name = params[:name]
    @email = params[:email]
    @content = params[:content]
  
    erb :form_output
  end



get '/hello' do
    name = params[:towa]
    "<h1>HEllo #{name}!</h1>"
end

get '/user/:user_name' do
    name = params[:name]
    "<h1>HEllo #{name}!</h1>"
end


get '/time' do
    Time.now.to_s
end
