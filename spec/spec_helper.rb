if RUBY_VERSION >= '1.9'
  require 'cover_me'
end

require 'rspec'
require 'gs_graph'
require 'gs_graph/mock'
include GSGraph::Mock
WebMock.disable_net_connect!