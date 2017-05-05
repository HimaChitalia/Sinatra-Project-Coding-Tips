class TipController < ApplicationController

    use Rack::Flash

    get '/:slug/tips' do
      @user = User.find_by_slug(params[:slug])
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
        if !params[:content].nil?
            @tip = Tip.create(content: params[:content])
            @tip.user = current_user
            if !params[:language][:name].nil? || !params[:language][:name].empty?
              @tip.language = Language.create(name: params[:language][:name])
            else
              @tip.language.id = params[:language_id]
            end
            @tip.save
            binding.pry
            @user = @tip.user
            redirect to "/tips/#{@tip.id}"
        else
            redirect "/tips/new"
        end
    end

    get '/tips/:id' do
        if logged_in?
          @tip = Tip.find_by_id(params[:id])
          if !@tip.nil?
            erb :'/tips/show'
          else
            "Ummm... looks like coding tip ##{params[:id]} doesn't exit. Are you trying to see any other coding tips?"
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
                flash[:message] = "Only #{current_user.username} is authorised to edit coding tip ##{@tip.id}."
                erb :'/tips/tips'
            end
        else
            redirect "/login"
        end
    end

    patch '/tips/:id' do
        @tip = Tip.find_by_id(params[:id])
        if !params[:content].empty?
            @tip.update(:content => params[:content])
            if !params[:language][:name].nil? || !params[:language][:name].empty?
              @tip.language = Language.create(name: params[:language][:name])
            else
              @tip.language.id = params[:language_id]
            end
            # @tip.language.id = params[:language_id]
            @user = @tip.user
            @tip.save
            erb :"/tips/tips"
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
            end
        else
            redirect "/login"
        end
    end
end
