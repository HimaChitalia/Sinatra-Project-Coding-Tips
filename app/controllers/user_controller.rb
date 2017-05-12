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
    if params[:username] == "" || params[:password] == "" || params[:email] == "" || params[:confirm_password] == ""
      redirect to '/signup'
      # binding.pry
    else
      user = User.create(username: params[:username], password: params[:password], password_confirmation: params[:confirm_password], email: params[:email])
      unless user.valid?
        return erb :'users/password_confirmation_error' if user.errors[:password_confirmation].any?
        return erb :'users/username_error' if user.errors[:username].any?
        return erb :'users/email_error' if user.errors[:email].any?
      end
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
      redirect to "#{user.username.downcase}/tips"
    end
      erb :'users/login_error'
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
      redirect to '/tips'
    end
  end

end
