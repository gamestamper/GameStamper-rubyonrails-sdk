require 'spec_helper'

describe GSGraph::Connections::Subscriptions, '#subscriptions' do
  context 'when included by GSGraph::Application' do
    context 'when access_token is given' do
      it 'should return liked pages as GSGraph::Page' do
        mock_graph :get, 'gs_graph/subscriptions', 'applications/subscriptions/gs_graph_private', :access_token => 'access_token' do
          subscriptions = GSGraph::Application.new('gs_graph', :access_token => 'access_token').subscriptions
          subscriptions.each do |subscription|
            subscription.should be_instance_of(GSGraph::Subscription)
          end
        end
      end
    end
  end
end

describe GSGraph::Connections::Subscriptions, '#subscribe!' do
  before do
    @app = GSGraph::Application.new('gs_graph', :access_token => 'access_token')
  end

  it 'should POST to /:app_id/subscriptions' do
    lambda do
      @app.subscribe!(
        :object => "user",
        :fields => "name,email",
        :callback_url => "http://fbgraphsample.heroku.com/subscription",
        :verify_token => "Define by yourself"
      )
    end.should request_to 'gs_graph/subscriptions', :post
  end
end

describe GSGraph::Connections::Subscriptions, '#unsubscribe!' do
  before do
    @app = GSGraph::Application.new('gs_graph', :access_token => 'access_token')
  end

  it 'should DELETE /:app_id/subscriptions' do
    mock_graph :delete, 'gs_graph/subscriptions', 'true', :params => {:object => 'user'}, :access_token => 'access_token' do
      @app.unsubscribe!(
        :object => 'user'
      )
    end
  end
end