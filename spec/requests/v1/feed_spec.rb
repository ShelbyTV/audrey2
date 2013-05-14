require 'spec_helper.rb'

describe 'Feeds' do

  it "should respond to GET" do
      get '/v1/feeds'
      last_response.should be_ok
      last_response.body.should have_json_path('feeds')
      last_response.body.should have_json_size(0).at_path('feeds')
  end

end