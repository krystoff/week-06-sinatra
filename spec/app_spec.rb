require 'app'
require 'rspec'
require 'rack/test'

set :environment, :test

describe "Twitter Info" do
  include Rack::Test::Methods

  def app
    TwitterInfo
  end

  it "should provide helpful instructions" do

    get "/"

    last_response.body.should match(/Append a twitter username on the url to display/)
    last_response.status.should == 200

  end

  it "should return a 500 status for any POST" do

    post "/user/burtlo"

    last_response.status.should == 500
    last_response.body.should match(/Sorry/)

  end


  ##
  # this spec needs to be written.
  #
  it "should display the user's follower count for any valid username" do
    
    get '/user/burtlo'
    
    last_response.status.should == 200
    last_response.body.should match(/burtlo/)
    last_response.body.should match(/h1.\d+..h1/)
    #puts last_response.body
  end  


  ##
  # this spec is a placeholder a feature that needs to be written.
  # please write the spec and the feature.
  # gold star for writing the spec before the lib code. :)
  #
  # hints:
  # use a begin/rescue/end block to rescue the error raised by
  # the Twitter gem when a username cannot be found.
  #
  # when that happens, return a new template file named 404.haml
  #
  it "should return a custom 404 page when the username cannot be found" do
    
    get '/user/DOES_NOT_EXIST_____'
    
    #puts "GOT==#{last_response.body}"
    last_response.body.should match(/Caps-Lock on.  Invalid username provided/)
    last_response.status.should == 404

  end
  
  #
  ## bonus/optional feature/spec test
  #
  it "should return the user's most recent tweet" do
    
    get '/user/burtlo'
    
    #puts "GOT==#{last_response.body}"
    last_response.status.should == 200
    last_response.body.should match(/burtlo/)
    last_response.body.should match(/h1.Last tweet: .*..h1/)

  end

end
