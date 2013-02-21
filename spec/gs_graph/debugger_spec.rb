require 'spec_helper'

describe GSGraph::Debugger::RequestFilter do
  let(:resource_endpoint) { 'https://graph.gamestamper.com/matake' }
  let(:request) { HTTP::Message.new_request(:get, URI.parse(resource_endpoint)) }
  let(:response) { HTTP::Message.new_response({:hello => 'world'}.to_json) }
  let(:request_filter) { GSGraph::Debugger::RequestFilter.new }

  describe '#filter_request' do
    it 'should log request' do
      [
        "======= [GSGraph] API REQUEST STARTED =======",
        request.dump
      ].each do |output|
        GSGraph.logger.should_receive(:info).with output
      end
      request_filter.filter_request(request)
    end
  end

  describe '#filter_response' do
    it 'should log response' do
      [
        "--------------------------------------------------",
        response.dump,
        "======= [GSGraph] API REQUEST FINISHED ======="
      ].each do |output|
        GSGraph.logger.should_receive(:info).with output
      end
      request_filter.filter_response(request, response)
    end
  end
end