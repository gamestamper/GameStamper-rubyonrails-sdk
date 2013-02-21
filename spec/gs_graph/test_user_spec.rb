require 'spec_helper'

describe GSGraph::TestUser, '.new' do

  it 'should setup all supported attributes' do
    attributes = {
      :id => 12345,
      :access_token => 'access_token',
      :name => 'nov',
      :login_url => 'https://www.gamestamper.com/login/test-user/12345',
      :email => 'test1@client.example.com',
      :password => 'password'
    }
    test_user = GSGraph::TestUser.new(attributes.delete(:id), attributes)
    test_user.login_url.should == 'https://www.gamestamper.com/login/test-user/12345'
    test_user.name.should == 'nov'
    test_user.email.should == 'test1@client.example.com'
    test_user.password.should == 'password'
  end

end

describe GSGraph::TestUser, '.friend!' do

  before do
    @u1 = GSGraph::TestUser.new(111, :access_token => 'token1')
    @u2 = GSGraph::TestUser.new(222, :access_token => 'token2')
  end

  it 'should POST twice' do
    mock_graph :post, '111/friends/222', 'true', :access_token => 'token1' do
      mock_graph :post, '222/friends/111', 'true', :access_token => 'token2' do
        @u1.friend! @u2
      end
    end
  end

end

describe GSGraph::TestUser, '.destroy' do
  before do
    @user = GSGraph::TestUser.new(111, :access_token => 'access_token')
  end

  it 'should DELETE /user_id' do
    mock_graph :delete, '111', 'true', :access_token => 'access_token' do
      @user.destroy
    end
  end
end