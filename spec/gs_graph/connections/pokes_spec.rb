require 'spec_helper'

describe GSGraph::Connections::Pokes do
  describe '#pokes' do
    it 'should return an Array of Poke' do
      mock_graph :get, 'me/pokes', 'users/pokes/sample', :access_token => 'access_token' do
        pokes = GSGraph::User.me('access_token').pokes
        pokes.should be_instance_of GSGraph::Connection
        pokes.should be_present
        pokes.each do |poke|
          poke.should be_instance_of GSGraph::Poke
        end
      end
    end
  end
end