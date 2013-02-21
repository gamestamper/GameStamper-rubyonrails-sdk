require 'spec_helper'

describe GSGraph::Connections::Links, '#links' do
  context 'when included by GSGraph::User' do
    it 'should return notes as GSGraph::Link' do
      mock_graph :get, 'matake/links', 'users/links/matake_private', :access_token => 'access_token' do
        links = GSGraph::User.new('matake', :access_token => 'access_token').links
        links.each do |link|
          link.should be_instance_of(GSGraph::Link)
        end
      end
    end
  end
end

describe GSGraph::Connections::Links, '#link!' do
  context 'when included by GSGraph::User' do
    it 'should return generated link' do
      mock_graph :post, 'matake/links', 'users/links/post_with_valid_access_token' do
        link = GSGraph::User.new('matake', :access_token => 'valid').link!(
          :link => 'http://github.com/nov/gs_graph',
          :message => 'A Ruby wrapper for Facebook Graph API.'
        )
        link.identifier.should == 120765121284251
        link.link.should == 'http://github.com/nov/gs_graph'
        link.message.should == 'A Ruby wrapper for Facebook Graph API.'
        link.access_token.should == 'valid'
      end
    end
  end
end