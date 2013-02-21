require 'spec_helper'

describe GSGraph::Connections::Notifications do
  describe '#notifications' do
    it 'should return notifications as GSGraph::Notification' do
      mock_graph :get, 'me/notifications', 'users/notifications/all', :params => {
        :include_read => 'true'
      }, :access_token => 'access_token' do
        notifications = GSGraph::User.me('access_token').notifications(:include_read => true)
        notifications.each do |notification|
          notification.should be_instance_of GSGraph::Notification
        end
      end
    end
  end

  describe '#notification!' do
    it 'should return success json' do
      mock_graph :post, 'matake/notifications', 'success', :params => {
        :template => 'hello'
      }, :access_token => 'app_access_token' do
        response = GSGraph::User.new('matake').notification!(
          :access_token => 'app_access_token',
          :template => 'hello'
        )
        response.should == {'success' => true}
      end
    end
  end
end
