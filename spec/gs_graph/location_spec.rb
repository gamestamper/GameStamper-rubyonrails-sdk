require 'spec_helper'

describe GSGraph::Location, '.new' do

  it 'should setup all supported attributes' do
    attributes = {
      :latitude => 30.2669,
      :longitude => -97.7428
    }
    location = GSGraph::Location.new(attributes)
    location.latitude.should == 30.2669
    location.longitude.should == -97.7428
  end

end

describe GSGraph::Location, '.to_hash' do

  it 'should setup all supported attributes' do
    attributes = {
      :latitude => 30.2669,
      :longitude => -97.7428
    }
    location = GSGraph::Location.new(attributes)
    location.to_hash == attributes
  end

end