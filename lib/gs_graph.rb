require 'httpclient'
require 'rack/oauth2'
require 'patch/rack/oauth2/util'
require 'patch/rack/oauth2/client'
require 'patch/rack/oauth2/access_token'

module GSGraph
  VERSION = ::File.read(
    ::File.join(::File.dirname(__FILE__), '../VERSION')
  ).delete("\n\r")
  ROOT_URL = "https://graph.gamestamper.com"

  def self.logger
    @@logger
  end
  def self.logger=(logger)
    @@logger = logger
  end
  self.logger = Logger.new(STDOUT)
  self.logger.progname = 'GSGraph'

  def self.debugging?
    @@debugging
  end
  def self.debugging=(boolean)
    Rack::OAuth2.debugging = boolean
    @@debugging = boolean
  end
  def self.debug!
    Rack::OAuth2.debug!
    self.debugging = true
  end
  def self.debug(&block)
    rack_oauth2_original = Rack::OAuth2.debugging?
    original = self.debugging?
    debug!
    yield
  ensure
    Rack::OAuth2.debugging = rack_oauth2_original
    self.debugging = original
  end
  self.debugging = false

  def self.http_client
    _http_client_ = HTTPClient.new(
      :agent_name => "GSGraph (#{VERSION})"
    )
    _http_client_.request_filter << Debugger::RequestFilter.new if debugging?
    http_config.try(:call, _http_client_)
    _http_client_
  end
  def self.http_config(&block)
    Rack::OAuth2.http_config &block unless Rack::OAuth2.http_config
    @@http_config ||= block
  end
end

require 'gs_graph/exception'
require 'gs_graph/debugger'

require 'gs_graph/auth'
require 'gs_graph/comparison'
require 'gs_graph/serialization'
require 'gs_graph/collection'
require 'gs_graph/connection'
require 'gs_graph/connections'
require 'gs_graph/searchable'

require 'gs_graph/action'
require 'gs_graph/age_range'
require 'gs_graph/device'
require 'gs_graph/education'
require 'gs_graph/location'
require 'gs_graph/picture'
require 'gs_graph/poke'
require 'gs_graph/privacy'
require 'gs_graph/role'
require 'gs_graph/subscription'
require 'gs_graph/targeting'
require 'gs_graph/venue'
require 'gs_graph/work'

require 'gs_graph/node'
require 'gs_graph/open_graph'
require 'gs_graph/achievement'
require 'gs_graph/ad_account'
require 'gs_graph/ad_campaign'
require 'gs_graph/ad_campaign_stat'
require 'gs_graph/ad_connection_object'
require 'gs_graph/ad_creative'
require 'gs_graph/ad_group'
require 'gs_graph/ad_group_stat'
require 'gs_graph/ad_keyword'
require 'gs_graph/ad_keyword_suggestion'
require 'gs_graph/ad_keyword_valid'
require 'gs_graph/broad_targeting_category'
require 'gs_graph/reach_estimate.rb'
require 'gs_graph/ad_preview.rb'
require 'gs_graph/album'
require 'gs_graph/app_request'
require 'gs_graph/application'
require 'gs_graph/checkin'
require 'gs_graph/comment'
require 'gs_graph/doc'
require 'gs_graph/domain'
require 'gs_graph/event'
require 'gs_graph/friend_list'
require 'gs_graph/friend_request'
require 'gs_graph/group'
require 'gs_graph/image'
require 'gs_graph/insight'
require 'gs_graph/link'
require 'gs_graph/message'
require 'gs_graph/milestone'
require 'gs_graph/note'
require 'gs_graph/notification'
require 'gs_graph/order'
require 'gs_graph/page'
require 'gs_graph/photo'
require 'gs_graph/cover'
require 'gs_graph/place'
require 'gs_graph/post'
require 'gs_graph/promotable_post'
require 'gs_graph/property'
require 'gs_graph/question'
require 'gs_graph/question_option'
require 'gs_graph/score'
require 'gs_graph/status'
require 'gs_graph/tab'
require 'gs_graph/tag'
require 'gs_graph/tagged_object'
require 'gs_graph/thread'
require 'gs_graph/user'
require 'gs_graph/user_achievement'
require 'gs_graph/video'
require 'gs_graph/offer'

# Load after GSGraph::User
require 'gs_graph/ad_user'
require 'gs_graph/test_user'

require 'gs_graph/klass'
require 'gs_graph/project'

require 'gs_graph/query'

require 'patch/rack/oauth2/access_token/introspectable'
