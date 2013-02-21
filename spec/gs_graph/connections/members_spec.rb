require 'spec_helper'

describe GSGraph::Connections::Members do
  let :member do
    GSGraph::User.new('member_id')
  end

  context 'when included in GSGraph::Group' do
    describe '#members' do
      it 'should return members as GSGraph::User' do
        mock_graph :get, 'emacs/members', 'groups/members/emacs_private', :access_token => 'access_token' do
          users = GSGraph::Group.new('emacs', :access_token => 'access_token').members
          users.each do |user|
            user.should be_instance_of GSGraph::User
          end
        end
      end
    end

    describe '#member!' do
      it :NOT_SUPPORTED_YET
    end

    describe '#unmember!' do
      it :NOT_SUPPORTED_YET
    end
  end

  context 'when included in GSGraph::FriendList' do
    describe '#members' do
      it 'should return members as GSGraph::User' do
        mock_graph :get, 'list_id/members', 'friend_lists/members/sample', :access_token => 'access_token' do
          users = GSGraph::FriendList.new('list_id', :access_token => 'access_token').members
          users.each do |user|
            user.should be_instance_of GSGraph::User
          end
        end
      end
    end

    describe '#member!' do
      it 'should return true' do
        mock_graph :post, 'list_id/members/member_id', 'true', :access_token => 'access_token' do
          GSGraph::FriendList.new('list_id', :access_token => 'access_token').member!(member).should be_true
        end
      end
    end

    describe '#unmember!' do
      it 'should return true' do
        mock_graph :delete, 'list_id/members/member_id', 'true', :access_token => 'access_token' do
          GSGraph::FriendList.new('list_id', :access_token => 'access_token').unmember!(member).should be_true
        end
      end
    end
  end
end