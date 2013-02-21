require 'spec_helper'

describe GSGraph::Connections::Threads, '#threads' do
  it 'should return threads as GSGraph::Thread' do
    mock_graph :get, 'me/threads', 'users/threads/me_private', :access_token => 'access_token' do
      threads = GSGraph::User.me('access_token').threads
      threads.each do |thread|
        thread.should be_instance_of(GSGraph::Thread)
      end
    end
  end
end