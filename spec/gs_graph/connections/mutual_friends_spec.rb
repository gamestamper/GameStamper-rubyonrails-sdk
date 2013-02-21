require 'spec_helper'

describe GSGraph::Connections::MutualFriends do
  let(:me) { GSGraph::User.me('access_token') }

  shared_examples_for :fetch_mutual_friends_between_me_and_friend do
    it 'should return an Array of GSGraph::User' do
      mock_graph :get, 'me/mutualfriends/agektmr', 'users/mutual_friends/me_and_agektmr', :access_token => 'access_token' do
        friends = me.mutual_friends(friend)
        friends.each do |friend|
          friend.should be_instance_of GSGraph::User
        end
      end
    end
  end

  describe '#mutual_friends' do
    context 'when friend is a GSGraph::User' do
      let(:friend) { GSGraph::User.new('agektmr') }
      it_behaves_like :fetch_mutual_friends_between_me_and_friend
    end

    context 'when friend is just an identifier' do
      let(:friend) { 'agektmr' }
      it_behaves_like :fetch_mutual_friends_between_me_and_friend
    end
  end
end