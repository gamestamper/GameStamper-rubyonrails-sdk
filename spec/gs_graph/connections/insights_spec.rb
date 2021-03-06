require 'spec_helper'

describe GSGraph::Connections::Insights do
  describe '#insights' do
    context 'when included by GSGraph::Page' do
      context 'when no access_token given' do
        it 'should raise GSGraph::Unauthorized' do
          mock_graph :get, 'GSGraph/insights', 'pages/insights/GSGraph_public', :status => [401, 'Unauthorized'] do
            lambda do
              GSGraph::Page.new('GSGraph').insights
            end.should raise_exception(GSGraph::Unauthorized)
          end
        end
      end

      context 'when access_token is given' do
        it 'should return insights as GSGraph::Insight' do
          mock_graph :get, 'GSGraph/insights', 'pages/insights/GSGraph_private', :access_token => 'access_token' do
            insights = GSGraph::Page.new('GSGraph').insights(:access_token => 'access_token')
            insights.class.should == GSGraph::Connection
            insights.first.should == GSGraph::Insight.new(
              '117513961602338/insights/page_fan_adds_unique/day',
              :access_token => 'access_token',
              :name => 'page_fan_adds_unique',
              :description => 'Daily New Likes of your Page (Unique Users)',
              :period => 'day',
              :values => [{
                :value => 1,
                :end_time => '2010-11-27T08:00:00+0000'
              }]
            )
            insights.each do |insight|
              insight.should be_instance_of(GSGraph::Insight)
            end
          end
        end
      end

      context 'when metrics is given' do
        it 'should treat metrics as connection scope' do
          mock_graph :get, 'GSGraph/insights/page_like_adds', 'pages/insights/page_like_adds/GSGraph_private', :access_token => 'access_token' do
            insights = GSGraph::Page.new('GSGraph').insights(:access_token => 'access_token', :metrics => :page_like_adds)
            insights.options.should == {
              :connection_scope => 'page_like_adds',
              :access_token => 'access_token'
            }
            insights.first.should == GSGraph::Insight.new(
              '117513961602338/insights/page_like_adds/day',
              :access_token => 'access_token',
              :name => 'page_like_adds',
              :description => 'Daily Likes of your Page\'s content (Total Count)',
              :period => 'day',
              :values => [{
                :value => 0,
                :end_time => '2010-12-09T08:00:00+0000'
              }, {
                :value => 0,
                :end_time => '2010-12-10T08:00:00+0000'
              }, {
                :value => 0,
                :end_time => '2010-12-11T08:00:00+0000'
              }]
            )
          end
        end

        it 'should support period also' do
          mock_graph :get, 'GSGraph/insights/page_like_adds/day', 'pages/insights/page_like_adds/day/GSGraph_private', :access_token => 'access_token' do
            insights = GSGraph::Page.new('GSGraph').insights(:access_token => 'access_token', :metrics => :page_like_adds, :period => :day)
            insights.options.should == {
              :connection_scope => 'page_like_adds/day',
              :access_token => 'access_token'
            }
            insights.first.should == GSGraph::Insight.new(
              '117513961602338/insights/page_like_adds/day',
              :access_token => 'access_token',
              :name => 'page_like_adds',
              :description => 'Daily Likes of your Page\'s content (Total Count)',
              :period => 'day',
              :values => [{
                :value => 1,
                :end_time => '2010-12-09T08:00:00+0000'
              }, {
                :value => 1,
                :end_time => '2010-12-10T08:00:00+0000'
              }, {
                :value => 1,
                :end_time => '2010-12-11T08:00:00+0000'
              }]
            )
          end
        end

        it 'should used for pagination' do
          mock_graph :get, 'GSGraph/insights/page_like_adds/day', 'pages/insights/page_like_adds/day/GSGraph_private', :access_token => 'access_token' do
            insights = GSGraph::Page.new('GSGraph').insights(:access_token => 'access_token', :metrics => :page_like_adds, :period => :day)
            expect { insights.next }.to request_to 'GSGraph/insights/page_like_adds/day?access_token=access_token&since=1292065709&until=1292324909'
            expect { insights.previous }.to request_to 'GSGraph/insights/page_like_adds/day?access_token=access_token&since=1291547309&until=1291806509'
          end
        end
      end
    end
  end
end
