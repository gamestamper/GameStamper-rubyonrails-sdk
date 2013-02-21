require 'spec_helper'

describe GSGraph::Connections::Books, '#books' do
  context 'when included by GSGraph::User' do
    context 'when no access_token given' do
      it 'should raise GSGraph::Unauthorized' do
        mock_graph :get, 'matake/books', 'users/books/matake_public', :status => [401, 'Unauthorized'] do
          lambda do
            GSGraph::User.new('matake').books
          end.should raise_exception(GSGraph::Unauthorized)
        end
      end
    end

    context 'when access_token is given' do
      it 'should return books as GSGraph::Page' do
        mock_graph :get, 'matake/books', 'users/books/matake_private', :access_token => 'access_token' do
          books = GSGraph::User.new('matake', :access_token => 'access_token').books
          books.first.should == GSGraph::Page.new(
            '102253616477130',
            :access_token => 'access_token',
            :name => 'Momo Michael Ende',
            :category => 'Unknown'
          )
          books.each do |book|
            book.should be_instance_of(GSGraph::Page)
          end
        end
      end
    end
  end
end