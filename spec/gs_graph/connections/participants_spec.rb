require 'spec_helper'

describe GSGraph::Connections::Participants, '#participants' do
  it 'should return participants as GSGraph::User' do
    mock_graph :get, '12345/participants', 'thread/participants/private', :params => {:no_cache => 'true'}, :access_token => 'access_token' do
      participants = GSGraph::Thread.new(12345, :access_token => 'access_token').participants(:no_cache => true)
      participants.each do |participant|
        participant.should be_instance_of(GSGraph::User)
      end
    end
  end

  describe 'cached messages' do
    context 'when cached' do
      let(:thread) { GSGraph::Thread.new(12345, :access_token => 'access_token', :participants => {}) }

      it 'should use cache' do
        lambda do
          thread.participants
        end.should_not request_to '12345/participants?access_token=access_token'
      end

      context 'when options are specified' do
        it 'should not use cache' do
          lambda do
            thread.participants(:no_cache => true)
          end.should request_to '12345/participants?access_token=access_token&no_cache=true'
        end
      end
    end

    context 'otherwise' do
      let(:thread) { GSGraph::Thread.new(12345, :access_token => 'access_token') }

      it 'should not use cache' do
        lambda do
          thread.participants
        end.should request_to '12345/participants?access_token=access_token'
      end
    end
  end
end