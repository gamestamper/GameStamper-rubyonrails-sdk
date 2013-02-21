require 'spec_helper'

describe GSGraph::Connections::Television, '#television' do
  it 'should return television pages as GSGraph::Page' do
    mock_graph :get, 'matake/television', 'users/television/matake_private', :access_token => 'access_token' do
      pages = GSGraph::User.new('matake', :access_token => 'access_token').television
      pages.each do |page|
        page.should be_instance_of(GSGraph::Page)
      end
    end
  end
end