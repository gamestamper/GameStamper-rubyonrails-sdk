require 'spec_helper'

describe GSGraph::Connections::Groups, '#groups' do
  context 'when included by GSGraph::User' do
    context 'when no access_token given' do
      it 'should raise GSGraph::Unauthorized' do
        mock_graph :get, 'matake/groups', 'users/groups/matake_public', :status => [401, 'Unauthorized'] do
          lambda do
            GSGraph::User.new('matake').groups
          end.should raise_exception(GSGraph::Unauthorized)
        end
      end
    end

    context 'when access_token is given' do
      it 'should return groups as GSGraph::Group' do
        mock_graph :get, 'matake/groups', 'users/groups/matake_private', :access_token => 'access_token' do
          groups = GSGraph::User.new('matake', :access_token => 'access_token').groups
          groups.first.should == GSGraph::Group.new(
            '115286585902',
            :access_token => 'access_token',
            :name => 'iPhone 3G S'
          )
          groups.each do |group|
            group.should be_instance_of(GSGraph::Group)
          end
        end
      end
    end
  end
end