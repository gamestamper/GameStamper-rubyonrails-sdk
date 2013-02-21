require 'spec_helper'

describe GSGraph::PromotablePost do
  let(:published) { GSGraph::PromotablePost.new(12345, :is_published => true) }
  let(:draft)     { GSGraph::PromotablePost.new(12345, :is_published => false) }
  let(:scheduled) { GSGraph::PromotablePost.new(12345, :is_published => false, :scheduled_publish_time => 2.days.from_now.to_i) }

  context 'when published' do
    subject { published }
    its(:publishable?) { should be_false }
    its(:scheduled?) { should be_false }
  end

  context 'when draft' do
    subject { draft }
    its(:publishable?) { should be_true }
    its(:scheduled?) { should be_false }
  end

  context 'when scheduled' do
    subject { scheduled }
    its(:publishable?) { should be_true }
    its(:scheduled?) { should be_true }
  end

  describe '.publish!' do
    it 'should post with is_published=true' do
      mock_graph :post, '12345', 'true', :access_token => 'page_token', :params => {
        :is_published => 'true'
      } do
        draft.publish!(:access_token => 'page_token').should be_true
      end
    end
  end

  describe '.schedule!' do
    it 'should post with scheduled_publish_time=timestamp' do
      scheduled_at = 2.days.from_now
      mock_graph :post, '12345', 'true', :access_token => 'page_token', :params => {
        :scheduled_publish_time => scheduled_at.to_i.to_s
      } do
        draft.schedule!(scheduled_at, :access_token => 'page_token').should be_true
      end
    end
  end

  describe '.unschedule!' do
    it 'should post with scheduled_publish_time=0' do
      scheduled_at = 2.days.from_now
      mock_graph :post, '12345', 'true', :access_token => 'page_token', :params => {
        :scheduled_publish_time => '0'
      } do
        scheduled.unschedule!(:access_token => 'page_token').should be_true
      end
    end
  end
end