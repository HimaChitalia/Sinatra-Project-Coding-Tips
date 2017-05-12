class TipController < ApplicationController

  use Rack::Flash

  get '/:slug/tips' do
    @user = User.find_with_slug(params[:slug])
    if logged_in? && session[:user_id] == @user.id
      erb :'/users/tips'
    else
      redirect to "/login"
    end
  end

  get '/tips' do
    erb :'/tips/tips'
  end

  get '/tips/new' do
    if logged_in?
      erb :'/tips/new'
    else
      redirect "/login"
    end
  end

  post '/tips' do
    @tip = current_user.tips.create(content: params[:content])
    if @tip.valid?
      if params[:language][:name].nil? || params[:language][:name].empty?
        @tip.language_id = params[:tip][:language_id]
      else
        new_language = Language.create(name: params[:language][:name])
        @tip.language_id = new_language.id
      end
      @tip.save
      @user = @tip.user
      redirect to "/tips/#{@tip.id}"
    else
      redirect "/tips/new"
    end
  end

  get '/tips/:id' do
    @id = params[:id]
    if logged_in?
      @tip = Tip.find_by_id(params[:id])
      if !@tip.nil?
        erb :'/tips/show'
      else
        erb :'/tips/show_error'
      end
    else
      redirect "/login"
    end
  end

  get '/tips/:id/edit' do
    if logged_in?
      @tip = Tip.find_by_id(params[:id])
      if @tip.user.username == current_user.username
        erb :'/tips/edit'
      else
        erb :'/tips/edit_error'
      end
    else
      redirect "/login"
    end
  end

  patch '/tips/:id' do
    @tip = current_user.tips.find_by(params[:id])
    if  @tip
      @tip.update(:content => params[:content])
      if params[:language][:name].nil? || params[:language][:name].empty?
        @tip.language_id = params[:tip][:language_id]
      else
        new_language = Language.create(name: params[:language][:name])
        @tip.language_id = new_language.id
      end
      @user = @tip.user
      @tip.save
      redirect "/tips/#{@tip.id}"
    else
      redirect "/tips/#{@tip.id}/edit"
    end
  end

  get '/tips/:id/delete' do
    @tip = Tip.find_by_id(params[:id])
    if logged_in?
      if current_user == @tip.user
          @tip.destroy
          redirect '/tips'
      else
          erb :'tips/delete_error'
      end
    else
      redirect "/login"
    end
  end

  get '/tips/:id/cancel' do
    redirect "/tips/#{@tip.id}"
  end
end
