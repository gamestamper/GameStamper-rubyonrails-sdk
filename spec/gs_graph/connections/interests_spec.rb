require 'spec_helper'

describe GSGraph::Connections::Interests, '#interests' do
  it 'should return interests pages as GSGraph::Page' do
    mock_graph :get, 'matake/interests', 'users/interests/matake_private', :access_token => 'access_token' do
      pages = GSGraph::User.new('matake', :access_token => 'access_token').interests
      pages.each do |page|
        page.should be_instance_of(GSGraph::Page)
      end
    end
  end
end