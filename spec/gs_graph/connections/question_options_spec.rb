require 'spec_helper'

describe GSGraph::Connections::QuestionOptions, '#options' do
  context 'when included by GSGraph::Question' do
    it 'should return options as GSGraph::QuestionOption' do
      mock_graph :get, '12345/options', 'questions/options/matake_private', :access_token => 'access_token' do
        question_options = GSGraph::Question.new('12345', :access_token => 'access_token').question_options
        question_options.each do |question_option|
          question_option.should be_instance_of(GSGraph::QuestionOption)
        end
      end
    end
  end
end
