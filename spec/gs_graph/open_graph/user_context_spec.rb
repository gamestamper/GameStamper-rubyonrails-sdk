require 'spec_helper'

describe GSGraph::OpenGraph::UserContext do
  let(:me) { GSGraph::User.me('access_token') }
  let(:app) { GSGraph::Application.new('app_id', :namespace => 'fbgraphsample') }

  describe '#og_actions' do
    it 'should return an array of GSGraph::OpenGraph::Action' do
      mock_graph :get, 'me/fbgraphsample:custom_action', 'open_graph/custom_actions', :access_token => 'access_token' do
        actions = me.og_actions(
          app.og_action('custom_action')
        )
        actions.each do |action|
          action.should be_instance_of GSGraph::OpenGraph::Action
        end
      end
    end
  end

  describe '#og_action!' do
    it 'should return GSGraph::OpenGraph::Action' do
      mock_graph :post, 'me/fbgraphsample:custom_action', 'open_graph/created', :access_token => 'access_token', :params => {
        :custom_object => 'http://samples.ogp.me/264755040233381'
      } do
        action = me.og_action!(
          app.og_action(:custom_action),
          :custom_object => 'http://samples.ogp.me/264755040233381'
        )
        action.should be_instance_of GSGraph::OpenGraph::Action
      end
    end
  end
end