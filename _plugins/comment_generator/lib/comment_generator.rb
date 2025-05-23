require 'sqlite3'
require 'comment_generator/comment'
require 'comment_generator/sqlite'
require 'comment_generator/rest'

module JekyllComments
  class Generator < Jekyll::Generator
    ##
    # Entrpoint to the generator, called by Jekyll
    def generate(site)
      @backend = if site.config['comments']['backend'] == 'sqlite'
                   CommentGenerator::Backends::SqliteBackend.new(site.config['comments']['db_file'])
                 else
                   api_token = ENV['COMMENTER_API_KEY'] || site.config['comments']['api_key'] || nil
                   CommentGenerator::Backends::RESTBackend.new(site.config['comments']['fetch_api'], api_token)
                 end

      @site = site
      gen_posts(site)
    end

    def gen_posts(site)
      site.posts.docs.each do |post|
        next unless post.data.key?('post_id')

        comments = @backend.assemble_comments(post.data['post_id'])
        post.data['comments'] = comments
      end
    end
  end
end
