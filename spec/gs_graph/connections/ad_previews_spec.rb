require 'spec_helper'

describe GSGraph::Connections::AdPreviews, '#ad_previews' do
  context 'when included by GSGraph::AdAccount' do
    context 'when access_token is given' do
      it 'should return ad_preview as GSGraph::AdPreview' do
        mock_graph :post, 'act_123456789/generatepreviews', 'ad_accounts/previews/test_ad_previews'  do
          ad_account = GSGraph::AdAccount.new('act_123456789', :access_token => 'access_token')
          ad_preview = ad_account.ad_previews(:access_token => 'access_token', :creative => {})
          ad_preview.should be_instance_of(GSGraph::AdPreview)
          ad_preview.preview_data[:body].should == '<h1>hello world</h1>'
        end
      end
    end
  end
end


