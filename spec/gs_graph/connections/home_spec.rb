# -*- coding: utf-8 -*-
require 'spec_helper'

describe GSGraph::Connections::Home, '#home' do
  context 'when included by GSGraph::User' do
    context 'when no access_token given' do
      it 'should raise GSGraph::Exception' do
        mock_graph :get, 'arjun/home', 'users/home/arjun_public', :status => [400, 'BadRequest'] do
          lambda do
            GSGraph::User.new('arjun').home
          end.should raise_exception(GSGraph::Exception)
        end
      end
    end

    context 'when identifier is not me' do
      it 'should raise GSGraph::Exception' do
        mock_graph :get, 'arjun/home', 'users/home/arjun_private', :access_token => 'access_token', :status => [400, 'BadRequest'] do
          lambda do
            GSGraph::User.new('arjun', :access_token => 'access_token').home
          end.should raise_exception(GSGraph::Exception)
        end
      end
    end

    context 'when identifier is me and no access_token is given' do
      it 'should raise GSGraph::Unauthorized' do
        mock_graph :get, 'me/home', 'users/home/me_public', :status => [401, 'Unauthorized'] do
          lambda do
            GSGraph::User.new('me').home
          end.should raise_exception(GSGraph::Unauthorized)
        end
      end
    end

    context 'when identifier is me and access_token is given' do
      it 'should return public posts in the user\'s news feed as GSGraph::Post' do
        mock_graph :get, 'me/home', 'users/home/me_private', :access_token => 'access_token' do
          posts = GSGraph::User.new('me', :access_token => 'access_token').home
          posts.first.should == GSGraph::Post.new(
            '634033380_112599768777073',
            :access_token => 'access_token',
            :from => {
              :id => '634033380',
              :name => 'nishikokura hironobu'
            },
            :message => "こちらこそありがとうございました！僕はctrl+無変換ですｗRT @_eskm: @pandeiro245　こないだの日曜はありがとうございました！面白い内容でした。ちなみにfnrirってCapsLockで起動ですが、英数変換と同じボタンでどうしてます？起動を違うボタンに変更",
            :icon => 'http://photos-h.ak.fbcdn.net/photos-ak-sf2p/v43/23/2231777543/app_2_2231777543_2528.gif',
            :created_time => '2010-04-27T13:06:14+0000',
            :updated_time => '2010-04-27T13:06:14+0000',
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