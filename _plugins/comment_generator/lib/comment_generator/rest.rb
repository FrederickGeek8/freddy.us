# lib/rest.rb

require 'net/http'
require 'json'
require 'comment_generator/comment'

module CommentGenerator::Backends
  class RESTBackend
    def initialize(fetch_endpoint)
      @fetch_endpoint = URI.parse(fetch_endpoint)
      @fetch_endpoint.query = 'post_id=hi'
    end

    def fetch_and_parse(uri)
      response = Net::HTTP.get_response(uri)
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
