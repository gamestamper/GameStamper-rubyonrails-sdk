require 'digest/md5'

module GSGraph
  class Auth
    # NOTE:
    # If you want access token, use GSGraph::Auth.new(APP_ID, APP_SECRET, :cookie => {..}) instead
    class Cookie
      def self.parse(client, cookie)
        signed_request = case cookie
        when String
          cookie
        else
          cookie["fbsr_#{client.identifier}"]
        end
        raise VerificationFailed.new('Facebook cookie not found') if signed_request.blank?
        SignedRequest.verify(client, signed_request)
      end
    end
  end
end