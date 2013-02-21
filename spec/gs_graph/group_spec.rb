require 'spec_helper'

describe GSGraph::Group, '.new' do

  it 'should setup all supported attributes' do
    attributes = {
      :id => '12345',
      :owner => {
        :id => '23456',
        :name => 'nov matake'
      },
      :name => 'group 1',
      :description => 'a group for gs_graph test',
      :link => 'http://www.gamestamper.com/group/12345',
      :privacy => 'OPEN',
      :updated_time => '2010-01-02T15:37:41+0000'
    }
    group = GSGraph::Group.new(attributes.delete(:id), attributes)
    group.identifier.should   == '12345'
    group.owner.should        == GSGraph::User.new('23456', :name => 'nov matake')
    group.name.should         == 'group 1'
    group.description.should  == 'a group for gs_graph test'
    group.link.should         == 'http://www.gamestamper.com/group/12345'
    group.privacy.should      == 'OPEN'
    group.updated_time.should == Time.parse('2010-01-02T15:37:41+0000')
  end

end