# lib/rest.rb

require 'net/http'
require 'json'
require 'comment_generator/comment'

module CommentGenerator::Backends
  class RESTBackend
    def initialize(fetch_endpoint, api_token)
      @fetch_endpoint = URI.parse(fetch_endpoint)
      @headers = if api_token.nil?
                   {}
                 else
                   { 'COMMENT-API-KEY' => api_token }
                 end
      @fetch_endpoint.query = 'post_id=hi'
    end

    def fetch_and_parse(uri)
      response = Net::HTTP.get_response(uri, @headers)
      Jekyll.logger.error "Error: Post #{uri} not found." if response.code != 200
      JSON.parse(response.body)
    end

    def assemble_comments(post_id)
      # NOTE: This assumes that the API returns the correctly formatted JSON (without conversion)
      #
      @fetch_endpoint.query = "post_id=#{post_id}"
      json_response = fetch_and_parse(@fetch_endpoint)
      json_response['comments']
    end
  end
end
