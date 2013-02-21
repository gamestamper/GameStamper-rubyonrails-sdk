require 'spec_helper'

describe GSGraph::Connections::Accounts do
  describe '#accounts' do
    context 'when included by GSGraph::User' do
      context 'when no access_token given' do
        it 'should raise GSGraph::Unauthorized' do
          mock_graph :get, 'matake/accounts', 'users/accounts/matake_public', :status => [401, 'Unauthorized'] do
            lambda do
              GSGraph::User.new('matake').accounts
            end.should raise_exception(GSGraph::Unauthorized)
          end
        end
      end

      context 'when access_token is given' do
        it 'should return accounts as GSGraph::Page or GSGraph::Application' do
          mock_graph :get, 'matake/accounts', 'users/accounts/matake_private', :access_token => 'access_token' do
            accounts = GSGraph::User.new('matake', :access_token => 'access_token').accounts
            accounts.class.should == GSGraph::Connection
            accounts.first.should == GSGraph::Page.new(
              '140478125968442',
              :access_token => 'access_token',
              :name => 'OAuth.jp',
              :category => 'Community organization',
              :perms => [
                "ADMINISTER",
                "EDIT_PROFILE",
                "CREATE_CONTENT",
                "MODERATE_CONTENT",
                "CREATE_ADS",
                "BASIC_ADMIN"
              ]
            )
            accounts.last.should == GSGraph::Application.new(
              '159306934123399',
              :access_token => 'access_token',
              :name => 'Rack::OAuth2 Sample'
            )
            accounts[0, 9].each do |account|
              account.should be_instance_of(GSGraph::Page)
            end
            accounts[9, 4].each do |account|
              account.should be_instance_of(GSGraph::Application)
            end
          end
        end

        context 'when manage_pages permission given' do
          it 'should has special access_token behalf of the page' do
            mock_graph :get, 'matake/accounts', 'users/accounts/matake_private_with_manage_pages_permission', :access_token => 'access_token_for_user' do
              accounts = GSGraph::User.new('matake', :access_token => 'access_token_for_user').accounts
              accounts.first.should == GSGraph::Page.new(
                '140478125968442',
                :access_token => 'access_token_for_oauth_jp',
                :name => 'OAuth.jp',
                :category => 'Technology'
              )
            end
          end
        end
      end
    end

    context 'when included by GSGraph::Application' do
      it 'should return an array of TestUser' do
        mock_graph :get, 'app/accounts', 'applications/accounts/private', :access_token => 'access_token_for_app' do
          accounts = GSGraph::Application.new('app', :access_token => 'access_token_for_app').accounts
          accounts.first.should == GSGraph::TestUser.new(
            '100002527044219',
            :access_token => '117950878254050|2.AQA7fQ_BuZqxAiHc.3600.1308646800.0-100002527044219|T1wRNmvnx5j5nw-2x00gZgdBjbo',
            :login_url => 'https://www.gamestamper.com/platform/test_account_login.php?user_id=100002527044219&n=SOlkQGg6Icr5BeI'
          )
        end
      end
    end
  end
end
