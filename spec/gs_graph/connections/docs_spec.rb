require 'spec_helper'

describe GSGraph::Connections::Docs do
  describe '#docs' do
    it 'should return docs as GSGraph::Doc' do
      mock_graph :get, 'my_group/docs', 'groups/docs/private', :access_token => 'access_token' do
        docs = GSGraph::Group.new('my_group', :access_token => 'access_token').docs
        docs.each do |doc|
          doc.should be_instance_of(GSGraph::Doc)
        end
      end
    end
  end
end