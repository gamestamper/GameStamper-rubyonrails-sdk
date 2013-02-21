require 'spec_helper'

describe GSGraph::Connections::SubscribedTo do
  it 'should return subscribees as GSGraph::User' do
    mock_graph :get, 'me/subscribedto', 'users/subscribed_to/sample', :access_token => 'access_token' do
      subscribees = GSGraph::User.me('access_token').subscribed_to
      subscribees.each do |subscribee|
        subscribee.should be_instance_of GSGraph::User
      end
    end
  end
end