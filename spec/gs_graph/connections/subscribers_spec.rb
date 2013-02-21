require 'spec_helper'

describe GSGraph::Connections::Subscribers do
  it 'should return subscribers as GSGraph::User' do
    mock_graph :get, 'me/subscribers', 'users/subscribers/sample', :access_token => 'access_token' do
      subscribers = GSGraph::User.me('access_token').subscribers
      subscribers.each do |subscriber|
        subscriber.should be_instance_of GSGraph::User
      end
    end
  end
end