require 'spec_helper'

describe GSGraph::Connections::Inbox, '#inbox' do
  context 'before message platform transition' do
    it 'should return threads as GSGraph::Thread::BeforeTransition' do
      mock_graph :get, 'me/inbox', 'users/inbox/before_transition', :access_token => 'access_token' do
        threads = GSGraph::User.me('access_token').inbox
        threads.each do |thread|
          thread.should be_instance_of(GSGraph::Thread::BeforeTransition)
        end
      end
    end
  end

  # TODO: after transition, check JSON format and put test here
end