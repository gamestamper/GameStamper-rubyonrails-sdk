require 'spec_helper'

describe GSGraph::Video, '.new' do

  it 'should setup all supported attributes' do
    mock_graph :get, 'video', 'videos/private', :access_token => 'access_token' do
      video = GSGraph::Video.new('video', :access_token => 'access_token').fetch
      video.from.should be_a GSGraph::User
      video.tags.should be_a Array
      video.tags.each do |tag|
        tag.should be_a GSGraph::Tag
      end
      [:name, :description, :embed_html, :icon, :source].each do |attribute|
        video.send(attribute).should be_a String
      end
      [:created_time, :updated_time].each do |attribute|
        video.send(attribute).should be_a Time
      end
    end
  end

  it 'should support page as from' do
    page_video = GSGraph::Video.new('12345', :from => {
      :id => '23456',
      :name => 'Smart.fm',
      :category => 'Web Site'
    })
    page_video.from.should == GSGraph::Page.new('23456', :name => 'Smart.fm', :category => 'Web Site')
  end

end