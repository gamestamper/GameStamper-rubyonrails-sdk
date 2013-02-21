require 'spec_helper'

describe GSGraph::Connections::Votes, '#votes' do
  context 'when included by GSGraph::QuestionOption' do
    it 'should return votes with user id and name' do
      mock_graph :get, '12345/votes', 'questions/options/votes/matake_private', :access_token => 'access_token' do
        votes = GSGraph::QuestionOption.new('12345', :access_token => 'access_token').votes
        votes.each do |vote|
          vote["id"].should_not be_blank
          vote["name"].should_not be_blank
        end
      end
    end
  end
end
