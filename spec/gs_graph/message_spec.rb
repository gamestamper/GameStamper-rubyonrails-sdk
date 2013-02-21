require 'spec_helper'

describe GSGraph::Message, '.new' do
  it 'should setup all supported attributes' do
    attributes = {
      :id => "12345",
      :created_time => "2011-02-04T15:11:05+0000",
      :tags => {
        :data => [{
          :name => "inbox"
        }, {
          :name => "source:web"
        }]
      },
      :from => {
        :name => "Nov Matake",
        :email => "abc@gamestamper.com",
        :id => "1575327134"
      },
      :to => {
        :data => [{
          :name => "Nov Matake",
          :email => "xyz@gamestamper.com",
          :id => "579612276"
        }, {
          :name => "Nov Matake",
          :email => "abc@gamestamper.com",
          :id => "1575327134"
        }]
      },
      :message => "test test"
    }
    message = GSGraph::Message.new(attributes.delete(:id), attributes)
    message.identifier.should == '12345'
    message.message.should == 'test test'
    message.created_time.should == Time.parse('2011-02-04T15:11:05+0000')
    message.tags.should == [
      GSGraph::Tag.new(:name => 'inbox'),
      GSGraph::Tag.new(:name => 'source:web')
    ]
    message.from.should == GSGraph::User.new('1575327134', :name => 'Nov Matake', :email => 'abc@gamestamper.com')
    message.to.should == [
      GSGraph::User.new('579612276', :name => 'Nov Matake', :email => 'xyz@gamestamper.com'),
      GSGraph::User.new('1575327134', :name => 'Nov Matake', :email => 'abc@gamestamper.com')
    ]
  end
end