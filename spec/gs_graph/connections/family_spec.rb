require 'spec_helper'

describe GSGraph::Connections::Family, '#family' do
  context 'when included by GSGraph::User' do
    context 'when no access_token given' do
      it 'should raise GSGraph::Unauthorized' do
        mock_graph :get, 'me/family', 'users/family/family_without_access_token', :status => [401, 'Unauthorized'] do
          lambda do
            GSGraph::User.new('me').family
          end.should raise_exception(GSGraph::Unauthorized)
        end
      end
    end

    context 'when access_token is given' do
      it 'should return family members as GSGraph::User' do
        mock_graph :get, 'me/family', 'users/family/me_public', :access_token => 'access_token' do
          users = GSGraph::User.new('me', :access_token => 'access_token').family
          users.first.should == GSGraph::User.new(
            '720112389',
            :access_token => 'access_token',
            :name => 'TD Lee',
            :relationship => 'brother'
          )
          users.each do |user|
            user.should be_instance_of(GSGraph::User)
          end
        end
      end
    end
  end
end