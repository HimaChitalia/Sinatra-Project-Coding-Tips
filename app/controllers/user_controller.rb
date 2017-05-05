class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/tips'
    end
  end

  post '/signup' do
    # binding.pry
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to '/signup'
      # binding.pry
    else
      user = User.create(username: params[:username], password: params[:password], email: params[:email])
      session[:user_id] = user.id
      redirect to '/tips'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/tips'
    end
  end

  post '/login' do
    # binding.pry
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tips'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      # binding.pry
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:slug' do
    if logged_in? && current_user.slug == params[:slug]
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect to '/login'
    end
  end



  # get '/tips'do
  #   "Please see the list of your tips."
  # end
end
