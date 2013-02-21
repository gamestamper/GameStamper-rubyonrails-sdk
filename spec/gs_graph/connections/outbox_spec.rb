require 'spec_helper'

describe GSGraph::Connections::Outbox, '#outbox' do
  context 'before message platform transition' do
    it 'should return threads as GSGraph::Thread::BeforeTransition' do
      mock_graph :get, 'me/outbox', 'users/outbox/me_private', :access_token => 'access_token' do
        threads = GSGraph::User.me('access_token').outbox
        threads.each do |thread|
          thread.should be_instance_of(GSGraph::Thread::BeforeTransition)
        end
      end
    end
  end

  # TODO: after transition, check JSON format and put test here
end