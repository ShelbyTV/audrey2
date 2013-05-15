require 'spec_helper.rb'

describe 'Feeds' do

  context "GET", :redis => true do

    it "should respond with success" do
        get '/v1/feeds'
        last_response.should be_ok
        last_response.body.should have_json_path('feeds')
        last_response.body.should have_json_size(0).at_path('feeds')
    end

    context "when there are some keys" do

      before(:each) do
        redis = Redis.new
        redis.hmset 'youtube:james','shelby_auth_token','123','shelby_roll_id','456'
        redis.hmset 'vimeo:josh','shelby_auth_token','789','shelby_roll_id','abc'
      end

      it "should return feed info for all feed types" do
        get '/v1/feeds'
        last_response.should be_ok
        last_response.body.should have_json_path('feeds')
        last_response.body.should have_json_type(Array).at_path('feeds')
        last_response.body.should have_json_size(2).at_path('feeds')
        last_response.body.should include_json({'id' => 'youtube:james', 'shelby_auth_token' => '123', 'shelby_roll_id' => '456'}.to_json).at_path('feeds').including('id')
        last_response.body.should include_json({'id' => 'vimeo:josh', 'shelby_auth_token' => '789', 'shelby_roll_id' => 'abc'}.to_json).at_path('feeds').including('id')
      end

      it "shoudl return feed info for only the feed type specified in the type param" do
        get '/v1/feeds?type=youtube'
        last_response.should be_ok
        last_response.body.should have_json_path('feeds')
        last_response.body.should have_json_type(Array).at_path('feeds')
        last_response.body.should have_json_size(1).at_path('feeds')
      end

    end

  end

end