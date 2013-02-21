require 'spec_helper'

describe GSGraph::Connections::Comments, '#comments' do
  context 'when included by GSGraph::Post' do
    let :post do
      mock_graph :get, 'no_comments', 'posts/no_comments' do
        GSGraph::Post.new('no_comments').fetch
      end
    end

    describe 'cached comments' do
      context 'when cached' do
        it 'should use cache' do
          lambda do
            post.comments
          end.should_not request_to "#{post.identifier}/comments"
        end

        context 'when options are specified' do
          it 'should not use cache' do
            lambda do
              post.comments(:no_cache => true)
            end.should request_to "#{post.identifier}/comments?no_cache=true"
          end
        end
      end

      context 'otherwise' do
        let(:post) { GSGraph::Post.new(12345, :access_token => 'access_token') }

        it 'should not use cache' do
          lambda do
            post.comments
          end.should request_to '12345/comments?access_token=access_token'
        end
      end
    end
  end
end

describe GSGraph::Connections::Comments, '#comment!' do
  context 'when included by GSGraph::Post' do
    context 'when no access_token given' do
      it 'should raise GSGraph::Exception' do
        mock_graph :post, '12345/comments', 'posts/comments/post_without_access_token', :status => [500, 'Internal Server Error'] do
          lambda do
            GSGraph::Post.new('12345').comment!(:message => 'hello')
          end.should raise_exception(GSGraph::Exception)
        end
      end
    end

    context 'when invalid access_token is given' do
      it 'should raise GSGraph::Exception' do
        mock_graph :post, '12345/comments', 'posts/comments/post_with_invalid_access_token', :status => [500, 'Internal Server Error'] do
          lambda do
            GSGraph::Post.new('12345', :access_token => 'invalid').comment!(:message => 'hello')
          end.should raise_exception(GSGraph::Exception)
        end
      end
    end

    context 'when valid access_token is given' do
      it 'should return generated comment' do
        mock_graph :post, '12345/comments', 'posts/comments/post_with_valid_access_token' do
          comment = GSGraph::Post.new('12345', :access_token => 'valid').comment!(:message => 'hello')
          comment.identifier.should == '117513961602338_119401698085884_535271'
          comment.access_token.should == 'valid'
          comment.message.should == 'hello'
          comment.access_token.should == 'valid'
        end
      end
    end
  end
end