require 'spec_helper'

describe GSGraph::Connections::TestUsers do
  describe '#test_users' do
    before do
      @app = GSGraph::Application.new('client_id', :secret => 'secret')
    end

    context 'when access_token is not given' do
      it 'should get access_token first' do
        lambda do
          @app.test_users
        end.should request_to('oauth/access_token', :post)
      end
    end

    context 'when access_token is given' do
      it 'should return test_users as GSGraph::TestUser' do
        mock_graph :get, 'client_id/accounts/test-users', 'applications/test_users/private', :access_token => 'access_token' do
          @app.access_token = 'access_token'
          test_users = @app.test_users
          test_users.each do |test_user|
            test_user.should be_instance_of(GSGraph::TestUser)
          end
        end
      end
    end
  end

  describe '#test_user!' do
    before do
      @app = GSGraph::Application.new('client_id', :secret => 'secret')
    end

    context 'when access_token is not given' do
      it 'should get access_token first' do
        lambda do
          @app.test_user!
        end.should request_to('oauth/access_token', :post)
      end
    end

    context 'when access_token is given' do
      before do
        @app.access_token = 'access_token'
      end

      it 'should return a GSGraph::TestUser' do
        mock_graph :post, 'client_id/accounts/test-users', 'applications/test_users/created' do
          @app.test_user!.should be_instance_of GSGraph::TestUser
        end
      end

      context 'when installed=false' do
        it 'should post "installed=false" as params' do
          mock_graph :post, 'client_id/accounts/test-users', 'applications/test_users/created', :access_token => 'access_token', :params => {
            :installed => 'false'
          } do
            @app.test_user!(:installed => false)
          end
        end
      end
    end
  end
end