require 'spec_helper'

describe GSGraph::Domain do
  describe '.search' do
    let :results do
      mock_graph :get, '/', 'domains/search_public', :params => {
        :domains => 'apple.com,fake.com'
      } do
        GSGraph::Domain.search('apple.com')
      end
    end

    it 'should return array of GSGraph::Domain' do
      results.each do |result|
        result.should be_instance_of(GSGraph::Domain)
      end
    end

    it 'should ignore fake.com' do
      results.collect(&:name).should_not include 'fake.com'
    end
  end
end