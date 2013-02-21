require 'spec_helper'

describe GSGraph::Thread, '.new' do
  it 'should setup all supported attributes' do
    attributes = {
      :id => "12345",
      :snippet => 'test message',
      :message_count => 2,
      :unread_count => 1,
      :updated_time => "2011-02-04T15:11:05+0000",
      :tags => {
        :data => [{
          :name => "inbox"
        }, {
          :name => "source:web"
        }]
      },
      :participants => {
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
      :senders => {
        :data => [{
          :name => "Nov Matake",
          :email => "abc@gamestamper.com",
          :id => "1575327134"
        }]
      },
      :messages => {
        :data => [{
          :id => "m_25aaa73097e54594addb418c7bfbd05c",
          :subject => "test",
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
          :message => "test"
        }],
        :paging => {
          :previous => "https://graph.gamestamper.com/?access_token=access_token",
          :next => "https://graph.gamestamper.com/?access_token=access_token"
        }
      }
    }
    thread = GSGraph::Thread.new(attributes.delete(:id), attributes)
    thread.identifier.should == '12345'
    thread.snippet.should == 'test message'
    thread.message_count.should == 2
    thread.unread_count.should == 1
    thread.updated_time.should == Time.parse('2011-02-04T15:11:05+0000')
    thread.tags.should == [
      GSGraph::Tag.new(:name => 'inbox'),
      GSGraph::Tag.new(:name => 'source:web')
    ]
    thread.senders.should == [
      GSGraph::User.new('1575327134', :name => 'Nov Matake', :email => 'abc@gamestamper.com')
    ]
  end
end