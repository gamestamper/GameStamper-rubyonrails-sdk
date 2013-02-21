require 'spec_helper'

describe GSGraph::Connections::Picture do
  describe '#picture' do
    context 'when included by GSGraph::User' do
      it 'should return image url' do
        GSGraph::User.new('matake').picture.should == File.join(GSGraph::ROOT_URL, 'matake/picture')
      end

      it 'should support size option' do
        [:square, :small, :normal, :large].each do |size|
          GSGraph::User.new('matake').picture(size).should == File.join(GSGraph::ROOT_URL, "matake/picture?type=#{size}")
          GSGraph::User.new('matake').picture(:type => size).should == File.join(GSGraph::ROOT_URL, "matake/picture?type=#{size}")
        end
      end

      it 'should support width option' do
        GSGraph::User.new('matake').picture(:width => 13).should == File.join(GSGraph::ROOT_URL, "matake/picture?width=13")
      end

      it 'should support height option' do
        GSGraph::User.new('matake').picture(:height => 37).should == File.join(GSGraph::ROOT_URL, "matake/picture?height=37")
      end

      it 'should support width and height options at the same time' do
        # Because we can't be sure of order of arguments and order by itself doesn't matter
        GSGraph::User.new('matake').picture(:width => 13, :height => 37).should satisfy { |uri| 
          [
            File.join(GSGraph::ROOT_URL, "matake/picture?width=13&height=37"),
            File.join(GSGraph::ROOT_URL, "matake/picture?height=37&width=13")
          ].include? uri
        }
      end

      context 'when no-redirect' do
        it 'should return Picture object' do
          mock_graph :get, 'matake/picture', 'users/picture/success', :params => {
            :redirect => 'false'
          } do
            picture = GSGraph::User.new('matake').picture(:redirect => false)
            picture.should be_instance_of GSGraph::Picture
          end
        end
      end
    end

    context 'when included by GSGraph::Page' do
      it 'should return image url' do
        GSGraph::Page.new('platform').picture.should == File.join(GSGraph::ROOT_URL, 'platform/picture')
      end

      it 'should support size option' do
        [:square, :small, :normal, :large].each do |size|
          GSGraph::Page.new('platform').picture(size).should == File.join(GSGraph::ROOT_URL, "platform/picture?type=#{size}")
          GSGraph::Page.new('platform').picture(:type => size).should == File.join(GSGraph::ROOT_URL, "platform/picture?type=#{size}")
        end
      end

      it 'should support width option' do
        GSGraph::Page.new('platform').picture(:width => 13).should == File.join(GSGraph::ROOT_URL, "platform/picture?width=13")
      end

      it 'should support height option' do
        GSGraph::Page.new('platform').picture(:height => 37).should == File.join(GSGraph::ROOT_URL, "platform/picture?height=37")
      end

      it 'should support width and height options at the same time' do
        GSGraph::Page.new('platform').picture(:width => 13, :height => 37).should satisfy { |uri| 
          [
            File.join(GSGraph::ROOT_URL, "platform/picture?width=13&height=37"),
            File.join(GSGraph::ROOT_URL, "platform/picture?height=37&width=13")
          ].include? uri
        }
      end    
    end
  end
end

describe GSGraph::Connections::Picture::Updatable do
  describe '#picture!' do
    it 'should update profile picture' do
      mock_graph :post, 'GSGraph/picture', 'true', :access_token => 'page_token', :params => {
        :picture => 'http://example.com/images/GSGraph.png'
      } do
        page = GSGraph::Page.new('GSGraph', :access_token => 'page_token')
        page.picture!(
          :picture => 'http://example.com/images/GSGraph.png'
        ).should be_true
      end
    end
  end
end