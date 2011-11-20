require 'sinatra'
require 'twitter'
require 'haml'

class TwitterInfo < Sinatra::Application

  set :views, settings.root + '/../views'

  get '/' do
    haml :index
  end

  get '/user/:username' do

    @user = params[:username]
    
    begin
      user_id = Twitter.user(@user).id
      followers = Twitter.follower_ids(user_id).ids
      @num_followers = followers.length
      @last_tweet = Twitter.user_timeline("#{@user}").first.text
  
      haml :followers
      
    rescue Twitter::Error => e
      
      #puts "Username #{@user}"
      @error = e.message
      status 404
      haml :_404
      
    end
    
  end

  post // do
    halt 500, 'Whoa. Sorry. No POSTs allowed.'
  end

end