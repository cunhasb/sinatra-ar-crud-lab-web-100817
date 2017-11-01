require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/posts' do
     @posts = Post.all
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    @post = Post.create(params)
    @post.save
    @posts=Post.all
    erb :posts
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end

  get '/posts/:id/edit' do
    @post= Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post=Post.find(params[:id])
    # binding.pry
    @post.update(params[:post])
    erb :show
    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id/delete' do
    # binding.pry
    @post = Post.find(params[:id])
    @post.delete
    erb :deleted

  end
end
