require 'spec_helper'

describe GSGraph::Connections::ReachEstimates, '#reach_estimates' do
  context 'when included by GSGraph::AdAccount' do
    context 'when access_token is given' do
      it 'should return reach_estimates as GSGraph::ReachEstimate' do
        mock_graph :get, 'act_123456789/reachestimate', 'ad_accounts/reach_estimates/test_reach_estimates', :params => {
          :targeting_spec => {:country => ["US"]}.to_json
        }, :access_token => 'access_token' do
          ad_account = GSGraph::AdAccount.new('act_123456789')
          reach_estimate = ad_account.reach_estimates(:access_token => 'access_token', :targeting_spec => {:country => ["US"]})
          reach_estimate.should be_instance_of(GSGraph::ReachEstimate)
        end
      end
    end
  end
end

