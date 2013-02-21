require 'spec_helper'

describe GSGraph::Connections::Photos, '#photos' do
  context 'when included by GSGraph::Album' do
    it 'should return photos as GSGraph::Photo' do
      mock_graph :get, '12345/photos', 'albums/photos/matake_private', :access_token => 'access_token' do
        photos = GSGraph::Album.new('12345', :access_token => 'access_token').photos
        photos.each do |photo|
          photo.should be_instance_of(GSGraph::Photo)
        end
      end
    end
  end
end

describe GSGraph::Connections::Photos, '#photo!' do
  it 'should return generated photo' do
    mock_graph :post, '12345/photos', 'albums/photos/post_with_valid_access_token' do
      photo = GSGraph::Album.new('12345', :access_token => 'valid').photo!(
        :source => Tempfile.new('image_file'),
        :message => 'Hello, where is photo?'
      )
      photo.identifier.should == 401111132276
      photo.name.should == 'Hello, where is photo?'
      photo.access_token.should == 'valid'
    end
  end

  it 'should support Tag' do
    mock_graph :post, '12345/photos', 'albums/photos/post_with_valid_access_token' do
      photo = GSGraph::Album.new('12345', :access_token => 'valid').photo!(
        :source => Tempfile.new('image_file'),
        :message => 'Hello, where is photo?',
        :tags => [GSGraph::Tag.new(:id => 12345, :name => 'me', :x => 0, :y => 10)]
      )
      photo.tags.should == [GSGraph::Tag.new(:id => 12345, :name => 'me', :x => 0, :y => 10)]
    end
  end
end