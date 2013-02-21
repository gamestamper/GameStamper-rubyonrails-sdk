require 'spec_helper'

describe GSGraph::Connections::Conversations do
  describe '#conversations' do
    let(:page) do
      GSGraph::Page.new('page_id', :access_token => 'page_token')
    end

    it 'should return an Array of GSGraph::Thread' do
      mock_graph :get, 'page_id/conversations', 'pages/conversations/list', :access_token => 'page_token' do
        conversations = page.conversations
        conversations.should be_instance_of GSGraph::Connection
        conversations.each do |conversation|
          conversation.should be_instance_of GSGraph::Thread
        end
      end
    end
  end
end