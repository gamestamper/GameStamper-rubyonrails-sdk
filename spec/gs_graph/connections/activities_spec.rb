# -*- coding: utf-8 -*-
require 'spec_helper'

describe GSGraph::Connections::Activities, '#activities' do
  context 'when included by GSGraph::User' do
    context 'when no access_token given' do
      it 'should raise GSGraph::Unauthorized' do
        mock_graph :get, 'arjun/activities', 'users/activities/arjun_public', :status => [401, 'Unauthorized'] do
          lambda do
            GSGraph::User.new('arjun').activities
          end.should raise_exception(GSGraph::Unauthorized)
        end
      end
    end

    context 'when access_token is given' do
      it 'should return activities as GSGraph::Page' do
        mock_graph :get, 'arjun/activities', 'users/activities/arjun_private', :access_token => 'access_token' do
          activities = GSGraph::User.new('arjun', :access_token => 'access_token').activities
          activities.class.should == GSGraph::Connection
          activities.first.should == GSGraph::Page.new(
            '378209722137',
            :access_token => 'access_token',
            :name => 'Doing Things at the Last Minute',
            :category => '活動'
          )
          activities.each do |activity|
            activity.should be_instance_of(GSGraph::Page)
          end
        end
      end
    end
  end
end
