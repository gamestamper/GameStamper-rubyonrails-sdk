require 'spec_helper'

describe GSGraph::Page do
  context 'for music category' do
    let :page do
      mock_graph :get, 'music', 'pages/categories/music' do
        GSGraph::Page.new('music').fetch
      end
    end
    subject { page }

    [
      :artists_we_like,
      :band_interests,
      :band_members,
      :booking_agent,
      :current_location,
      :influences,
      :press_contact,
      :record_label
    ].each do |key|
      its(key) { should be_instance_of String }
    end
  end
end