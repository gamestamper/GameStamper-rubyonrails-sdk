# -*- coding: utf-8 -*-
require 'spec_helper'

describe GSGraph::Connections::Likes do
  describe '#likes' do
    context 'when no access_token given' do
      it 'should raise GSGraph::Unauthorized' do
        mock_graph :get, 'arjun/likes', 'users/likes/arjun_public', :status => [401, 'Unauthorized'] do
          lambda do
            GSGraph::User.new('arjun').likes
          end.should raise_exception(GSGraph::Unauthorized)
        end
      end
    end

    context 'when access_token is given' do
      it 'should return liked pages as GSGraph::Page' do
        mock_graph :get, 'arjun/likes', 'users/likes/arjun_private', :access_token => 'access_token' do
          likes = GSGraph::User.new('arjun', :access_token => 'access_token').likes
          likes.first.should == GSGraph::Page.new(
            '378209722137',
            :access_token => 'access_token',
            :name => 'Doing Things at the Last Minute',
            :category => '活動'
          )
          likes.each do |like|
            like.should be_instance_of(GSGraph::Page)
          end
        end
      end
    end
  end

  describe '#like?' do
    let(:user)     { GSGraph::User.new(579612276, :access_token => 'access_token') }
    let(:gs_graph) { GSGraph::Page.new(117513961602338) }
    let(:poken)    { GSGraph::Page.new(1234567890) }

    context 'when liked' do
      it 'should retrun true' do
        mock_graph :get, '579612276/likes/117513961602338', 'users/likes/gs_graph', :access_token => 'access_token' do
          user.like?(gs_graph).should be_true
        end
      end
    end

    context 'otherwise' do
      it 'should retrun true' do
        mock_graph :get, '579612276/likes/1234567890', 'users/likes/poken', :access_token => 'access_token' do
          user.like?(poken).should be_false
        end
      end
    end
  end
end