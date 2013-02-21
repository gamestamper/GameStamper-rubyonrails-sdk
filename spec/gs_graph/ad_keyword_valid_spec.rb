require 'spec_helper'

describe GSGraph::AdKeywordValid, '.search' do
  it 'should perform a search' do
    mock_graph :get, 'search', 'ad_keyword_valids/tige_search', :params => {:keyword_list => 'tige', :type => 'adkeywordvalid'} do
      valid_results = GSGraph::AdKeywordValid.search('tige')

      valid_results.size.should == 1
      valid_results.first.should be_instance_of(GSGraph::AdKeywordValid)
      valid_results.first.should_not be_valid
      valid_results.first.name.should == "tige"

      valid_results.first.suggestions.size.should == 1
      valid_results.first.suggestions.first.should be_instance_of(GSGraph::AdKeyword)
      valid_results.first.suggestions.first.name.should == "#Tigerstyle"
      valid_results.first.suggestions.first.should be_topic_keyword
    end
  end
end
