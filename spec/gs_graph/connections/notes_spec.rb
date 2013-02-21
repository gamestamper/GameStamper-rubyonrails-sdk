require 'spec_helper'

describe GSGraph::Connections::Notes, '#notes' do
  context 'when included by GSGraph::User' do
    it 'should return notes as GSGraph::Note' do
      mock_graph :get, 'matake/notes', 'users/notes/matake_private', :access_token => 'access_token' do
        notes = GSGraph::User.new('matake', :access_token => 'access_token').notes
        notes.each do |note|
          note.should be_instance_of(GSGraph::Note)
        end
      end
    end
  end
end

describe GSGraph::Connections::Notes, '#note!' do
  context 'when included by GSGraph::Page' do
    it 'should return generated note' do
      mock_graph :post, '12345/notes', 'pages/notes/post_with_valid_access_token', :params => {
        :subject => 'test',
        :message => 'hello'
      }, :access_token => 'valid' do
        note = GSGraph::Page.new('12345', :access_token => 'valid').note!(:subject => 'test', :message => 'hello')
        note.identifier.should == 396664845100
        note.subject.should == 'test'
        note.message.should == 'hello'
        note.access_token.should == 'valid'
      end
    end
  end
end