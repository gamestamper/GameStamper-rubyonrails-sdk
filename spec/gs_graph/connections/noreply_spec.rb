require 'spec_helper'

describe GSGraph::Connections::Noreply do
  let(:event) do
    GSGraph::Event.new('smartday', :access_token => 'access_token')
  end

  describe '#no_reply' do
    it 'should return noreply users as GSGraph::User' do
      mock_graph :get, 'smartday/noreply', 'events/noreply/smartday_private', :access_token => 'access_token' do
        event.no_reply.each do |user|
          user.should be_instance_of(GSGraph::User)
        end
      end
    end
  end

  describe '#no_reply?' do
    context 'when no_reply' do
      it 'should return true' do
        mock_graph :get, 'smartday/noreply/uid', 'events/invited/not_replied', :access_token => 'access_token' do
          event.no_reply?(
            GSGraph::User.new('uid')
          ).should be_true
        end
      end
    end

    context 'otherwise' do
      it 'should return false' do
        mock_graph :get, 'smartday/noreply/uid', 'empty', :access_token => 'access_token' do
          event.no_reply?(
            GSGraph::User.new('uid')
          ).should be_false
        end
      end
    end
  end
end