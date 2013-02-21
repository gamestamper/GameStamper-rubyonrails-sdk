require 'spec_helper'

describe GSGraph::Post, '.new' do
  it 'should setup all supported attributes' do
    attributes = {
      :id => "579612276_10150089741782277",
      :message => "hello",
      :from => {
        :name => "Nov Matake",
        :id => "579612276"
      },
      :to => {
        :data => [{
          :name => "Jr Nov",
          :id => "1575327134"
        }]
      },
      :with_tags => {
        :data => [{
          :name => "Jr Nov",
          :id => "1575327134"
        }]
      },
      :icon => "http://photos-d.ak.fbcdn.net/photos-ak-snc1/v27562/23/2231777543/app_2_2231777543_9553.gif",
      :type => "status",
      :object_id => "12345",
      :actions => [{
        :name => "Comment",
        :link => "http://www.gamestamper.com/579612276/posts/10150089741782277"
      }, {
        :name => "Like",
        :link => "http://www.gamestamper.com/579612276/posts/10150089741782277"
      }, {
        :name => "@nov on Twitter",
        :link => "http://twitter.com/nov?utm_source=fb&utm_medium=fb&utm_campaign=nov&utm_content=19294280413614080"
      }],
      :application => {
        :name => "Twitter",
        :id => "2231777543"
      },
      :properties => [
        {
           :name => "Source",
           :text => "TechCrunch Japan",
           :href => "http://jp.techcrunch.com/"
        },
        {
           :name => "Published",
           :text => "2011-06-22 05:11:18 GMT"
        }
      ],
      :privacy => {
        :value => "EVERYONE",
        :description => "Everyone"
      },
      :targeting => {
        :country => 'ja'
      },
      :created_time => "2010-12-27T07:31:30+0000",
      :updated_time => "2010-12-27T07:31:30+0000"
    }
    post = GSGraph::Post.new(attributes.delete(:id), attributes)
    post.identifier.should == '579612276_10150089741782277'
    post.message.should == 'hello'
    post.from.should == GSGraph::User.new("579612276", :name => 'Nov Matake')
    post.to.first.should == GSGraph::User.new("1575327134", :name => 'Jr Nov')
    post.with_tags.first.should == GSGraph::User.new("1575327134", :name => 'Jr Nov')
    post.icon.should == 'http://photos-d.ak.fbcdn.net/photos-ak-snc1/v27562/23/2231777543/app_2_2231777543_9553.gif'
    post.type.should == 'status'
    post.graph_object_id.should == '12345'
    post.properties.each do |property|
      property.should be_a GSGraph::Property
    end
    post.actions.should == [
      GSGraph::Action.new(
        :name => "Comment",
        :link => "http://www.gamestamper.com/579612276/posts/10150089741782277"
      ),
      GSGraph::Action.new(
        :name => "Like",
        :link => "http://www.gamestamper.com/579612276/posts/10150089741782277"
      ),
      GSGraph::Action.new(
        :name => "@nov on Twitter",
        :link => "http://twitter.com/nov?utm_source=fb&utm_medium=fb&utm_campaign=nov&utm_content=19294280413614080"
      )
    ]
    post.application.should == GSGraph::Application.new(
      "2231777543",
      :name => "Twitter"
    )
    post.privacy.should == GSGraph::Privacy.new(
      :value => "EVERYONE",
      :description => "Everyone"
    )
    post.targeting.should == GSGraph::Targeting.new(
      :country => 'ja'
    )
    post.created_time.should == Time.parse("2010-12-27T07:31:30+0000")
    post.updated_time.should == Time.parse("2010-12-27T07:31:30+0000")
  end

  it 'should support GSGraph::Privacy as privacy' do
    post = GSGraph::Post.new(12345, :privacy => GSGraph::Privacy.new(:value => 'EVERYONE'))
    post.privacy.should == GSGraph::Privacy.new(:value => 'EVERYONE')
  end

  it 'should support GSGraph::Targeting as targeting' do
    post = GSGraph::Post.new(12345, :targeting => GSGraph::Targeting.new(:country => 'ja'))
    post.targeting.should == GSGraph::Targeting.new(:country => 'ja')
  end

  it 'should support page as from' do
    page_post = GSGraph::Post.new('12345', :from => {
      :id => '23456',
      :name => 'Smart.fm',
      :category => 'Web Site'
    }, :message => 'Hello')
    page_post.from.should == GSGraph::Page.new('23456', :name => 'Smart.fm', :category => 'Web Site')
  end

  it 'should support page as to' do
    page_post = GSGraph::Post.new('12345', :to => {:data => [
      :id => '23456',
      :name => 'Smart.fm',
      :category => 'Web Site'
    ]}, :message => 'Hello')
    page_post.to.first.should == GSGraph::Page.new('23456', :name => 'Smart.fm', :category => 'Web Site')
  end
end

describe GSGraph::Post, '#fetch' do

  context 'when no access_token given' do
    it 'should get all attributes except some comments' do
      mock_graph :get, 'platform', 'posts/platform_public' do
        post = GSGraph::Post.fetch('platform')
        post.identifier.should == '19292868552_118464504835613'
        post.from.should == GSGraph::Page.new(
          "19292868552",
          :name => "Facebook Platform",
          :category => "Technology"
        )
        post.message.should == "We're getting ready for f8! Check out the latest on the f8 Page, including a video from the first event, when Platform launched :: http://bit.ly/ahHl7j"
        post.likes.should == [
          GSGraph::User.new("100000785546814", :name => "Anter Saied")
        ]
        post.likes.collection.total_count.should == 270
        post.created_time.should == Time.parse("2010-04-15T17:37:03+0000")
        post.updated_time.should == Time.parse("2010-04-22T18:19:13+0000")
        post.comments.size.should == 4
      end
    end
  end

  context 'when access_token given' do
    it 'shold get all attributes and comments' do
      mock_graph :get, 'platform', 'posts/platform_private', :access_token => 'access_token' do
        post = GSGraph::Post.fetch('platform', :access_token => 'access_token')
        post.identifier.should == '19292868552_118464504835613'
        post.from.should == GSGraph::Page.new(
          "19292868552",
          :name => "Facebook Platform",
          :category => "Technology"
        )
        post.message.should == "We're getting ready for f8! Check out the latest on the f8 Page, including a video from the first event, when Platform launched :: http://bit.ly/ahHl7j"
        post.created_time.should == Time.parse("2010-04-15T17:37:03+0000")
        post.updated_time.should == Time.parse("2010-04-22T18:19:13+0000")
        post.comments.size.should == 9
      end
    end
  end

  context 'when include "story"' do
    it 'should include story and story_tags' do
      mock_graph :get, 'post_id', 'posts/with_story', :access_token => 'access_token' do
        post = GSGraph::Post.fetch('post_id', :access_token => 'access_token')
        post.story.should == 'Nov Matake likes Instagram JP.'
        post.story_tags.should be_a Array
        post.story_tags.each do |story_tag|
          story_tag.should be_instance_of GSGraph::TaggedObject
        end
      end
    end
  end

  context 'when include "story"' do
    it 'should include message and message_tags' do
      mock_graph :get, 'post_id', 'posts/with_message', :access_token => 'access_token' do
        post = GSGraph::Post.fetch('post_id', :access_token => 'access_token')
        post.message.should == 'testing status message with tagged people. Jr Nov'
        post.message_tags.should be_a Array
        post.message_tags.each do |message_tag|
          message_tag.should be_instance_of GSGraph::TaggedObject
        end
      end
    end
  end

  context 'when include "place"' do
    it 'should include place as Venue' do
      mock_graph :get, 'post_id', 'posts/with_place', :access_token => 'access_token' do
        post = GSGraph::Post.fetch('post_id', :access_token => 'access_token')
        place = post.place
        place.should be_instance_of GSGraph::Place
        place.identifier.should == '100563866688613'
        place.name.should == 'Kawasaki-shi, Kanagawa, Japan'
        location = place.location
        location.should be_instance_of GSGraph::Venue
        location.latitude.should == 35.5167
        location.longitude.should == 139.7
      end
    end
  end
end

describe GSGraph::Post, '#to' do
  subject { post.to.first }

  context 'when include Event' do
    let :post do
      mock_graph :get, 'to_event', 'posts/to_event' do
        GSGraph::Post.fetch('to_event')
      end
    end
    it { should be_instance_of GSGraph::Event }
  end

  context 'when include Group' do
    let :post do
      mock_graph :get, 'to_group', 'posts/to_group', :access_token => 'access_token' do
        GSGraph::Post.fetch('to_group', :access_token => 'access_token')
      end
    end
    it { should be_instance_of GSGraph::Group }
  end

end