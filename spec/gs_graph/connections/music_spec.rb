require 'spec_helper'

describe GSGraph::Connections::Music, '#music' do
  it 'should return music pages as GSGraph::Page' do
    mock_graph :get, 'matake/music', 'users/music/matake_private', :access_token => 'access_token' do
      pages = GSGraph::User.new('matake', :access_token => 'access_token').music
      pages.each do |page|
        page.should be_instance_of(GSGraph::Page)
      end
    end
  end
end