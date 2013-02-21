require 'spec_helper'

describe GSGraph::Connections::Activities, '#activities' do
  it 'should return games as GSGraph::Page' do
    mock_graph :get, 'matake/games', 'users/games/matake_private', :access_token => 'access_token' do
      games = GSGraph::User.new('matake', :access_token => 'access_token').games
      games.class.should == GSGraph::Connection
      games.first.should == GSGraph::Page.new(
        '101392683235776',
        :access_token => 'access_token',
        :name => 'FarmVille Cows',
        :category => 'Game',
        :created_time => '2011-01-05T13:37:40+0000'
      )
      games.each do |game|
        game.should be_instance_of(GSGraph::Page)
      end
    end
  end
end
