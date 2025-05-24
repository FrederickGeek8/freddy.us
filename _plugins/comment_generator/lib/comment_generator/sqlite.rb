# lib/sqlite.rb

require 'comment_generator/comment'

module CommentGenerator::Backends
  class SqliteBackend
    def initialize(db_file)
      @db_file = db_file
      @query = 'SELECT * FROM comments WHERE post = :post_id'
    end

    def query_comments(post_id)
      SQLite3::Database.new @db_file, readonly: true do |db|
        db.results_as_hash = true

        db.prepare(@query) do |stmt|
          stmt.bind_param 'post_id', post_id
          result = stmt.execute.to_a
          count = result.count

          Jekyll.logger.info 'Jekyll SQLite:', "Count=#{count}"
          return result
        end
      end
    end

    def assemble_comments(post_id)
      query_results = query_comments(post_id)

      comments_w_id = {}
      query_results.each do |comment_row|
        # only display approved comments!
        next unless comment_row['status'] == 'approved'

        current_elem = CommentGenerator::Comment.new(comment_row)

        comments_w_id[current_elem.parent].replies.append(current_elem) unless current_elem.parent.nil?

        comments_w_id[current_elem.id] = current_elem
      end

      comments_w_id.filter_map { |_, v| v.to_hash if v.parent.nil? }
    end
  end
end
