class LanguageController < ApplicationController

    use Rack::Flash

    get '/tips/language/:name' do
      @language = "#{params[:name]}"
      @tips = []
      @tips = Tip.all.find_all do |tip|
       tip.language.name.downcase == @language.downcase
      end
      if !@tips.empty?
        erb :'languages/show'
      else
        erb :'languages/error'
      end
   end

end
