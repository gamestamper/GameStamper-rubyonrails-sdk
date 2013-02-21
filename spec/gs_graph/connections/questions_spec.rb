require 'spec_helper'

describe GSGraph::Connections::Questions do
  describe '#questions' do
    it 'should return an Array of Questions' do
      mock_graph :get, 'me/questions', 'users/questions/sample', :access_token => 'access_token' do
        questions = GSGraph::User.me('access_token').questions
        questions.class.should == GSGraph::Connection
        questions.each do |question|
          question.should be_instance_of(GSGraph::Question)
        end
      end
    end
  end

  describe '#question!' do
    it 'should return GSGraph::Question without cached question_options collection' do
      mock_graph :post, 'me/questions', 'users/questions/created', :params => {
        :question => 'Do you like gs_graph?',
        :options => ['Yes', 'Yes!', 'Yes!!'].to_json
      }, :access_token => 'access_token' do
        question = GSGraph::User.me('access_token').question!(
          :question => 'Do you like gs_graph?',
          :options => ['Yes', 'Yes!', 'Yes!!']
        )
        question.should be_instance_of(GSGraph::Question)
        expect { question.question_options }.to request_to "#{question.identifier}/options"
      end
    end
  end
end