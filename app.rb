require 'sinatra'
require 'fileutils'
require 'sinatra/reloader'
require 'sinatra/cookies'
enable :sessions

set :public_folder, 'public'


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


post '/login' do
    if get_session_user()
      redirect '/', 302
    end

    user = try_login(params['account_name'], params['password'])
    if user
      session[:user] = {
        id: user[:id]
      }
      session[:csrf_token] = SecureRandom.hex(16)
      redirect '/', 302
    else
      flash[:notice] = 'アカウント名かパスワードが間違っています'
      redirect '/login', 302
    end
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



# ----------upload--------------
get "/upload" do

    @images = Dir.glob("./public/image/*").map{|path| path.split('/').last }
    erb :upload

end

post "/upload" do
    @file_name = params[:file][:filename]
    FileUtils.mv(params[:file][:tempfile], "./public/image/#{@file_name}")
    # erb :uploaded
    redirect "/upload"
end




    # erb :uploaded
# redirect '/upload


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






# get '/hello' do
#     @name = params[:towa]
#     "<h1>HEllo #{name}!</h1>"
#     erb :hello
# end



# /hello?name=sabo
get '/hello' do
    # query string から取得
    # @name = params[:name]
    session[:name] = params[:name]

    erb :hello
end




get '/user/:user_name' do
    name = params[:name]
    "<h1>HEllo #{name}!</h1>"
end


get '/time' do
    Time.now.to_s
end
