require 'spec_helper'

describe GSGraph::Searchable do
  describe '.search' do
    context 'when included by GSGraph::Page' do
      it 'should with type=page' do
        lambda do
          GSGraph::Searchable.search('GSGraph')
        end.should request_to('search?q=GSGraph')
      end
    end
  end

  describe '#search' do
    context 'when included by GSGraph::Page' do
      it 'should with type=page' do
        lambda do
          GSGraph::Page.search('GSGraph')
        end.should request_to('search?q=GSGraph&type=page')
      end
    end
  end
end

describe GSGraph::Searchable::Result do
  let :gs_graph do
    mock_graph :get, 'search?q=fbgraph&type=page', 'pages/search_gs_graph' do
      GSGraph::Page.search('fbgraph')
    end
  end
  let :google_page2 do
    mock_graph :get, 'search?limit=25&offset=25&q=google&type=page', 'pages/search_google' do
      GSGraph::Page.search('google', :limit => 25, :offset => 25)
    end
  end

  it 'should support pagination' do
    gs_graph.next.should     == []
    gs_graph.previous.should == []
    lambda do
      google_page2.next
    end.should request_to('search?limit=25&offset=50&q=google&type=page')
    lambda do
      google_page2.previous
    end.should request_to('search?limit=25&offset=0&q=google&type=page')
  end
end