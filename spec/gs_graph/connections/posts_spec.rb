require 'spec_helper'

describe GSGraph::Connections::Posts, '#posts' do
  context 'when included by GSGraph::User' do
    context 'when no access_token given' do
      it 'should return public posts the user created as GSGraph::Post' do
        mock_graph :get, 'arjun/posts', 'users/posts/arjun_public' do
          posts = GSGraph::User.new('arjun').posts
          posts.first.should == GSGraph::Post.new(
            '7901103_121392141207495',
            :from => {
              :id => '7901103',
              :name => 'Arjun Banker'
            },
            :picture => 'http://external.ak.fbcdn.net/safe_image.php?d=d2cc5beedaa401ba54eccc9014647285&w=130&h=130&url=http%3A%2F%2Fimages.ted.com%2Fimages%2Fted%2F269_389x292.jpg',
            :link => 'http://www.ted.com/talks/wade_davis_on_endangered_cultures.html',
            :name => 'Wade Davis on endangered cultures | Video on TED.com',
            :caption => 'www.ted.com',
            :description => 'TED Talks With stunning photos and stories, National Geographic Explorer Wade Davis celebrates the extraordinary diversity of the world\'s indigenous cultures, which are disappearing from the planet at an alarming rate.',
            :icon => 'http://static.ak.fbcdn.net/rsrc.php/z9XZ8/hash/976ulj6z.gif',
            :created_time => '2010-04-25T04:05:32+0000',
            :updated_time => '2010-04-25T04:05:32+0000',
            :privacy => {
              :value => 'EVERYONE'
            }
          )
          posts.each do |post|
            post.should be_instance_of(GSGraph::Post)
          end
        end
      end
    end
  end
end