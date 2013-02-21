require 'spec_helper'

describe GSGraph::Connections::Movies, '#movies' do
  it 'should return movies pages as GSGraph::Page' do
    mock_graph :get, 'matake/movies', 'users/movies/matake_private', :access_token => 'access_token' do
      pages = GSGraph::User.new('matake', :access_token => 'access_token').movies
      pages.each do |page|
        page.should be_instance_of(GSGraph::Page)
      end
    end
  end
end