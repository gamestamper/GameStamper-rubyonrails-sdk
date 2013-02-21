require 'spec_helper'

describe GSGraph::FriendList do

  it 'should setup all supported attributes' do
    attributes = {
      :id => '12345',
      :name => 'My List'
    }
    video = GSGraph::FriendList.new(attributes.delete(:id), attributes)
    video.identifier.should == '12345'
    video.name.should       == 'My List'
  end

  describe 'destroy' do
    it 'should return true' do
      mock_graph :delete, 'list_id', 'true', :access_token => 'access_token' do
        GSGraph::FriendList.new('list_id').destroy(:access_token => 'access_token').should be_true
      end
    end
  end
end