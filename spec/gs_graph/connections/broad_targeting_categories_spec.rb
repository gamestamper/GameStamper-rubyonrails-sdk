require 'spec_helper'

describe GSGraph::Connections::BroadTargetingCategories, '#broad_targeting_categories' do
  context 'when included by GSGraph::AdAccount' do
    context 'when access_token is given' do
      it 'should return broad_targeting_categories as GSGraph::BroadTargetingCategory' do
        mock_graph :get, 'act_22334455/broadtargetingcategories', 'ad_accounts/broad_targeting_categories/test_bct', :access_token => 'access_token' do
          bcts = GSGraph::AdAccount.new("act_22334455").broad_targeting_categories(:access_token => 'access_token')
          bcts.size.should == 3
          bcts.each {|x| x.should be_instance_of(GSGraph::BroadTargetingCategory)}
          bcts[0].identifier.should == 6002714885172
          bcts[0].name.should == "Cooking"
          bcts[0].parent_category.should == "Activities"
        end
      end
    end
  end
end
