require 'spec_helper'

describe GSGraph::Comment, '.new' do

  it 'should setup all supported attributes' do
    attributes = {
      :id => '12345',
      :from => {
        :id => '23456',
        :name => 'nov matake'
      },
      :message => 'hello',
      :created_time => '2010-01-02T15:37:40+0000'
    }
    comment = GSGraph::Comment.new(attributes.delete(:id), attributes)
    comment.identifier.should   == '12345'
    comment.from.should         == GSGraph::User.new('23456', :name => 'nov matake')
    comment.message.should      == 'hello'
    comment.created_time.should == Time.parse('2010-01-02T15:37:40+0000')
  end

  it 'should support page as from' do
    page_comment = GSGraph::Comment.new('12345', :from => {
      :id => '23456',
      :name => 'Smart.fm',
      :category => 'Web Site'
    })
    page_comment.from.should == GSGraph::Page.new('23456', :name => 'Smart.fm', :category => 'Web Site')
  end

end