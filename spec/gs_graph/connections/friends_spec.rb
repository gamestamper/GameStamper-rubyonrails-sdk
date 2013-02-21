require 'spec_helper'

describe GSGraph::Connections::Friends, '#friends' do
  context 'when included by GSGraph::User' do
    context 'when no access_token given' do
      it 'should raise GSGraph::Unauthorized' do
        mock_graph :get, 'arjun/friends', 'users/friends/arjun_public', :status => [401, 'Unauthorized'] do
          lambda do
            GSGraph::User.new('arjun').friends
          end.should raise_exception(GSGraph::Unauthorized)
        end
      end
    end

    context 'when identifier is not me' do
      it 'should raise GSGraph::Unauthorized' do
        mock_graph :get, 'arjun/friends', 'users/friends/arjun_private', :access_token => 'access_token', :status => [401, 'Unauthorized'] do
          lambda do
            GSGraph::User.new('arjun', :access_token => 'access_token').friends
          end.should raise_exception(GSGraph::Unauthorized)
        end
      end
    end

    context 'when identifier is me and no access_token is given' do
      it 'should raise GSGraph::Unauthorized' do
        mock_graph :get, 'me/friends', 'users/friends/me_public', :status => [401, 'Unauthorized'] do
          lambda do
            GSGraph::User.new('me').friends
          end.should raise_exception(GSGraph::Unauthorized)
        end
      end
    end

    context 'when identifier is me and access_token is given' do
      it 'should return friends as GSGraph::User' do
        mock_graph :get, 'me/friends', 'users/friends/me_private', :access_token => 'access_token' do
          users = GSGraph::User.new('me', :access_token => 'access_token').friends
          users.first.should == GSGraph::User.new(
            '6401',
            :access_token => 'access_token',
            :name => 'Kirk McMurray'
          )
          users.each do |user|
            user.should be_instance_of(GSGraph::User)
          end
        end
      end
    end
  end
end