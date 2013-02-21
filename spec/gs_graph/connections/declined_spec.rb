require 'spec_helper'

describe GSGraph::Connections::Declined do
  let(:event) do
    GSGraph::Event.new('smartday', :access_token => 'access_token')
  end

  describe '#declined' do
    it 'should return declined users as GSGraph::User' do
      mock_graph :get, 'smartday/declined', 'events/declined/smartday_private', :access_token => 'access_token' do
        event.declined.each do |user|
          user.should be_instance_of(GSGraph::User)
        end
      end
    end
  end

  describe '#declined?' do
    context 'when declined' do
      it 'should return true' do
        mock_graph :get, 'smartday/declined/uid', 'events/invited/declined', :access_token => 'access_token' do
          event.declined?(
            GSGraph::User.new('uid')
          ).should be_true
        end
      end
    end

    context 'otherwise' do
      it 'should return false' do
        mock_graph :get, 'smartday/declined/uid', 'empty', :access_token => 'access_token' do
          event.declined?(
            GSGraph::User.new('uid')
          ).should be_false
        end
      end
    end
  end

  describe '#declined!' do
    it 'should return true' do
      mock_graph :post, 'smartday/declined', 'events/declined/post_with_valid_access_token', :access_token => 'access_token' do
        event.declined!.should be_true
      end
    end
  end
end