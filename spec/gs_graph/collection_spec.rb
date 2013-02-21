require 'spec_helper'

describe GSGraph::Collection, '.new' do

  it 'should return an array with pagination info' do
    mock_graph :get, 'platform/statuses', 'pages/statuses/platform_private', :access_token => 'access_token' do
      collection = GSGraph::Page.new('platform', :access_token => 'access_token').statuses.collection
      collection.should be_kind_of(Array)
      collection.previous.should be_kind_of(Hash)
      collection.next.should be_kind_of(Hash)
    end
  end

  it 'should allow blank data' do
    patterns = [
      GSGraph::Collection.new,
      GSGraph::Collection.new({}),
      GSGraph::Collection.new({:count => 5}),
      GSGraph::Collection.new(nil)
    ]
    patterns.each do |collection|
      collection.should be_kind_of(Array)
      collection.previous.should be_kind_of(Hash)
      collection.next.should be_kind_of(Hash)
      collection.should be_blank
      collection.previous.should be_blank
      collection.next.should be_blank
    end
  end

  it 'should fetch count as total_count' do
    collection = GSGraph::Collection.new({:count => 5})
    collection.total_count.should == 5
  end

  it 'should accept Array' do
    collection = GSGraph::Collection.new([1, 2, 3])
    collection.total_count.should == 3
    collection.should == [1, 2, 3]
    collection.previous.should be_blank
    collection.next.should be_blank
  end

  it 'should raise error for invalid input' do
    lambda do
      GSGraph::Collection.new("STRING")
    end.should raise_error(ArgumentError, 'Invalid collection')
  end

end