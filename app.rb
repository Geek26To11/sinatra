require 'sinatra'
require 'fileutils'
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
    #POSTのリクエストボディから値を取得
    @name = params[:name]
    @email = params[:email]
    @content = params[:content]
    # ファイルに保存する 下記のかっこ内にあるform.txtファイルが作成され内容がそこに保存される
    # File.open("form.txt", mode = "a"){|f|
    # f.write("#{@name},#{@email},#{@content}\n")
    # }
    # FileUtils.mv(params[:img][:tempfile], "./public/images/#{params[:img][:filename]}")
    erb :form_output
  end


get "/upload" do
    erb :upload
end



post '/save_image' do

@filename = params[:file][:filename]
file = params[:file][:tempfile]

File.open("./public/image/#{@filename}", 'wb') do |f|
    f.write(file.read)
end


    erb :show_image
end

# FileUtils.mv(params[:img][:tempfile],
# "./public/images/#{params[:img][:filename]}")






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
