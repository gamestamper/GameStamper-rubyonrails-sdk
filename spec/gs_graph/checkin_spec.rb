require 'spec_helper'

describe GSGraph::Checkin, '.new' do
  it 'should accept GSGraph::Place as place' do
    checkin = GSGraph::Checkin.new(12345, :place => GSGraph::Place.new(123456))
    checkin.place.should == GSGraph::Place.new(123456)
  end

  it 'should accept String/Integer as place' do
    checkin1 = GSGraph::Checkin.new(12345, :place => 123456)
    checkin2 = GSGraph::Checkin.new(12345, :place => '123456')
    checkin1.place.should == GSGraph::Place.new(123456)
    checkin2.place.should == GSGraph::Place.new('123456')
  end
end

describe GSGraph::Checkin, '.search' do
  context 'when no access_token given' do
    it 'should raise GSGraph::Unauthorized' do
      mock_graph :get, 'search', 'checkins/search_public', :params => {
        :type => 'checkin'
      }, :status => [401, 'Unauthorized'] do
        lambda do
          GSGraph::Checkin.search
        end.should raise_exception(GSGraph::Unauthorized)
      end
    end
  end

  context 'when access_token is given' do
    it 'should return checkins as GSGraph::Checkin' do
      mock_graph :get, 'search', 'checkins/search_private', :access_token => 'access_token', :params => {
        :type => 'checkin'
      } do
        checkins = GSGraph::Checkin.search(:access_token => 'access_token')
        checkins.each do |checkin|
          checkin.should be_instance_of(GSGraph::Checkin)
        end
      end
    end
  end
end
