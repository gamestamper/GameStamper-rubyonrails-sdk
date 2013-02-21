require 'spec_helper'

describe GSGraph::Notification do
  let :attributes do
    {
      :id => 'notif_579612276_139149416',
      :title => 'Nobuhiro Nakajima commented on your status.',
      :message => 'Actual Comment Here',
      :link => 'http://www.gamestamper.com/matake/posts/10150574049082277',
      :unread => 0,
      :application => {
        :id => '19675640871',
        :name => 'Feed Comments'
      },
      :from => {
        :id => '1260873121',
        :name => 'Nobuhiro Nakajima'
      },
      :to => {
        :id => '579612276',
        :name => 'Nov Matake'
      },
      :created_time => '2012-01-25T04:01:09+0000',
      :updated_time => '2012-01-25T04:01:20+0000'
    }
  end

  it 'should setup all supported attributes' do
    notification = GSGraph::Notification.new(attributes[:id], attributes)
    notification.identifier.should == attributes[:id]
    notification.title.should      == attributes[:title]
    notification.message.should    == attributes[:message]
    notification.link.should       == attributes[:link]
    notification.unread.should be_false
    notification.application.should == GSGraph::Application.new(
      attributes[:application][:id], attributes[:application]
    )
    notification.from.should == GSGraph::User.new(
      attributes[:from][:id], attributes[:from]
    )
    notification.to.should == GSGraph::User.new(
      attributes[:to][:id], attributes[:to]
    )
    notification.created_time.should == Time.parse('2012-01-25T04:01:09+0000')
    notification.updated_time.should == Time.parse('2012-01-25T04:01:20+0000')
  end

  describe '#read!' do
    it 'should update unread to read' do
      mock_graph :post, 'notification_id', 'true', :params => {
        :unread => 'false'
      }, :access_token => 'access_token' do
        GSGraph::Notification.new('notification_id').read!(
          :access_token => 'access_token'
        ).should be_true
      end
    end
  end
end
