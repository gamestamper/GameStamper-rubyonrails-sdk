require 'spec_helper'

describe GSGraph::Place, '.to_json' do
  it 'should return identifier' do
    place = GSGraph::Place.new(12345)
    place.to_json.should == 12345
  end
end