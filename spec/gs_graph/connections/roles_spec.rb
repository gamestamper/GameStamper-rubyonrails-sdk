require 'spec_helper'

describe GSGraph::Connections::Roles do
  let(:app) do
    GSGraph::Application.new('app_id', :secret => 'app_secret')
  end

  describe '#roles' do
    it 'should return an Array of GSGraph::Role' do
      mock_graph :post, 'oauth/access_token', 'app_token_response' do
        mock_graph :get, 'app_id/roles', 'applications/roles/list', :access_token => 'app_token' do
          roles = app.roles
          roles.should be_instance_of GSGraph::Connection
          roles.each do |role|
            role.should be_instance_of GSGraph::Role
          end
          roles.first.user.should == GSGraph::User.new('579612276')
          roles.first.application.== GSGraph::Application.new('210798282372757')
          roles.first.role.should == 'administrators'
        end
      end
    end
  end

  {
    :admin!         => 'administrators',
    :developer!     => 'developers',
    :tester!        => 'testers',
    :insights_user! => 'insights users'
  }.each do |method, role|
    describe "##{method}" do
      it 'should return true' do
        mock_graph :post, 'app_id/roles', 'true', :access_token => 'admin_user_token', :params => {
          :user => 'new_admin_uid',
          :role => role
        } do
          app.send(
            method,
            GSGraph::User.new('new_admin_uid'),
            :access_token => 'admin_user_token'
          ).should be_true
        end
      end
    end
  end

  describe '#unrole!' do
    it 'should return true' do
      mock_graph :delete, 'app_id/roles', 'true', :access_token => 'role_owner_token', :params => {
        :user => 'role_owner_uid'
      } do
        app.unrole!(
          GSGraph::User.new('role_owner_uid'),
          :access_token => 'role_owner_token'
        ).should be_true
      end
    end
  end
end