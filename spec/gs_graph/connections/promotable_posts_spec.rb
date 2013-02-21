require 'spec_helper'

describe GSGraph::Connections::PromotablePosts do
  describe '#promotable_posts' do
    it 'should return promotable posts the user created as GSGraph::Post' do
      mock_graph :get, 'GSGraph/promotable_posts', 'pages/promotable_posts/sample', :access_token => 'access_token' do
        posts = GSGraph::Page.new('GSGraph', :access_token => 'access_token').promotable_posts
        posts.class.should == GSGraph::Connection
        posts.count.should == 4
        posts.each.with_index do |post, index|
          post.should be_instance_of GSGraph::PromotablePost
          case index
          when 0
            post.is_published.should be_false
            post.scheduled_publish_time.should == Time.at(1352473200)
          else
            post.is_published.should be_true
            post.scheduled_publish_time.should be_nil
          end
        end
      end
    end
  end
end