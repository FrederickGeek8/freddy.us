# lib/comment.rb

module CommentGenerator
  class Comment
    attr_accessor :id, :parent, :columns, :timestamp, :replies

    def initialize(comment_query_row)
      @id = comment_query_row['id']
      @parent = comment_query_row['parent'] || nil
      @columns = comment_query_row
      @timestamp = comment_query_row['created_at']
      @replies = []
    end

    def to_hash
      {
        'id' => @id,
        'parent' => @parent,
        'columns' => @columns,
        'timestamp' => @timestamp,
        'replies' => @replies.map { |r| r.to_hash }
      }
    end
  end
end
