require 'spec_helper'

describe GSGraph::Connections::Videos do
  describe '#videos' do
    it 'should return videos as GSGraph::Video' do
      mock_graph :get, 'kirk/videos', 'users/videos/kirk_private', :access_token => 'access_token' do
        videos = GSGraph::User.new('kirk', :access_token => 'access_token').videos
        videos.each do |video|
          video.should be_instance_of(GSGraph::Video)
        end
      end
    end
  end

  describe '#video!' do
    it 'should return generated photo' do
      mock_graph :post, 'me/videos', 'users/videos/posted' do
        me = GSGraph::User.me('access_token')
        video = me.video!(
          :source => Tempfile.new('movie_file')
        )
        video.should be_a GSGraph::Video
        video.identifier.should == '10150241488822277'
      end
    end
  end
end