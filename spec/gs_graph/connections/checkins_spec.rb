require 'spec_helper'

describe GSGraph::Connections::Checkins do
  describe '#checkins' do
    context 'when included by GSGraph::User' do
      context 'when no access_token given' do
        it 'should raise GSGraph::Unauthorized' do
          mock_graph :get, 'mattt/checkins', 'users/checkins/mattt_public', :status => [401, 'Unauthorized'] do
            lambda do
              GSGraph::User.new('mattt').checkins
            end.should raise_exception(GSGraph::Unauthorized)
          end
        end
      end

      context 'when access_token is given' do
        it 'should return checkins as GSGraph::Checkin' do
          mock_graph :get, 'mattt/checkins', 'users/checkins/mattt_private', :access_token => 'access_token' do
            checkins = GSGraph::User.new('mattt', :access_token => 'access_token').checkins
            checkins.first.should == GSGraph::Checkin.new(
              '696876187499',
              :access_token => 'access_token',
              :from => {
                :id => '12820552',
                :name => 'Roger Pincombe'
              },
              :tags => {
                :data => [{
                  :id => '4810308',
                  :name => 'Mattt Thompson'
                }]
              },
              :message => 'Checking out Austin, TX',
              :place => {
                :id => '120454134658381',
                :name => 'Gowalla HQ',
                :location => {
                  :latitude => 30.26876,
                  :longitude => -97.74962
                }
              },
              :application => {
                :id => '6628568379',
                :name => 'Facebook for iPhone'
              },
              :created_time => '2010-09-08T00:09:25+0000'
            )
            checkins.each do |checkin|
              checkin.should be_instance_of(GSGraph::Checkin)
            end
          end
        end
      end
    end

    context 'when included by GSGraph::Page' do
      context 'when no access_token given' do
        it 'should raise GSGraph::Unauthorized' do
          mock_graph :get, 'gowalla/checkins', 'pages/checkins/gowalla_public', :status => [401, 'Unauthorized'] do
            lambda do
              GSGraph::Page.new('gowalla').checkins
            end.should raise_exception(GSGraph::Unauthorized)
          end
        end
      end

      context 'when access_token is given' do
        it 'should return checkins as GSGraph::Checkin' do
          mock_graph :get, 'gowalla/checkins', 'pages/checkins/gowalla_private', :access_token => 'access_token' do
            checkins = GSGraph::Page.new('gowalla', :access_token => 'access_token').checkins
            checkins.first.should == GSGraph::Checkin.new(
              '696876187499',
              :access_token => 'access_token',
              :from => {
                :id => '12820552',
                :name => 'Roger Pincombe'
              },
              :tags => {
                :data => [{
                  :id => '4810308',
                  :name => 'Mattt Thompson'
                }]
              },
              :message => 'Checking out Austin, TX',
              :place => {
                :id => '120454134658381',
                :name => 'Gowalla HQ',
                :location => {
                  :latitude => 30.26876,
                  :longitude => -97.74962
                }
              },
              :application => {
                :id => '6628568379',
                :name => 'Facebook for iPhone'
              },
              :created_time => '2010-09-08T00:09:25+0000'
            )
            checkins.each do |checkin|
              checkin.should be_instance_of(GSGraph::Checkin)
            end
          end
        end
      end
    end
  end

  describe '#checkin!' do
    it 'should POST :user_id/checkins' do
      mock_graph :post, 'me/checkins', 'users/checkins/posted' do
        checkin = GSGraph::User.me('token').checkin!(
          :place => 'place_id',
          :coordinates => {
            :latitude => 30.26876,
            :longitude => -97.74962
          }.to_json
        )
        checkin.identifier.should == '10150090286117277'
        checkin.place.should == GSGraph::Place.new('place_id')
      end
    end

    context 'when tags are given' do
      it 'should allow single tag' do
        mock_graph :post, 'me/checkins', 'users/checkins/posted' do
          checkin = GSGraph::User.me('token').checkin!(
            :place => 'place_id',
            :coordinates => {
              :latitude => 30.26876,
              :longitude => -97.74962
            }.to_json,
            :tags => 'friend_1'
          )
          checkin.tags.should == [GSGraph::User.new('friend_1')]
        end
      end

      it 'should allow multiple tags' do
        mock_graph :post, 'me/checkins', 'users/checkins/posted' do
          checkin = GSGraph::User.me('token').checkin!(
            :place => 'place_id',
            :coordinates => {
              :latitude => 30.26876,
              :longitude => -97.74962
            }.to_json,
            :tags => ['friend_1', 'friend_2']
          )
          checkin.tags.should == [GSGraph::User.new('friend_1'), GSGraph::User.new('friend_2')]
        end
      end
    end
  end
end