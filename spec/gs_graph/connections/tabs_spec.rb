require 'spec_helper'

describe GSGraph::Connections::Tabs do
  let(:page) { GSGraph::Page.new('GSGraph', :access_token => 'page_token') }

  describe '#tabs' do
    it 'should return tabs as GSGraph::Tab' do
      mock_graph :get, 'GSGraph/tabs', 'pages/tabs/gs_graph', :access_token => 'page_token' do
        page.tabs.each do |tab|
          tab.should be_a GSGraph::Tab
        end
      end
    end
  end

  describe '#tab!' do
    it 'should add a tab' do
      mock_graph :post, 'GSGraph/tabs', 'true', :access_token => 'page_token', :params => {
        :app_id => '12345'
      } do
        page.tab!(:app_id => 12345).should be_true
      end
    end
  end

  describe '#tab?' do
    context 'when installed' do
      it 'shoud return true' do
        mock_graph :get, 'GSGraph/tabs/wall', 'pages/tabs/wall', :access_token => 'page_token' do
          page.tab?(
            GSGraph::Application.new('wall')
          ).should be_true
        end
      end
    end

    context 'otherwise' do
      it 'shoud return false' do
        mock_graph :get, 'GSGraph/tabs/app_id', 'pages/tabs/blank', :access_token => 'page_token' do
          page.tab?(
            GSGraph::Application.new('app_id')
          ).should be_false
        end
      end
    end
  end
end