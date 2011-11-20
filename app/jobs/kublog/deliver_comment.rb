module Kublog
  class DeliverComment
  
    def initialize(comment_id)
      @comment_id = comment_id
    end
  
    def perform
      comment = Comment.find(@comment_id)
      CommentMailer.new_comment(comment).deliver
    end
  
  end
end