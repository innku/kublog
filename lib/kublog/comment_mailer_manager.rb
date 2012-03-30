class CommentMailerManager
  def self.necessary_notifications?(comment)
    if comment.post.invited_author
      true 
    else
      comment.user != comment.post.user
    end
  end

  def self.comment_observers_emails(comment)
    post = comment.post
    comment_email = comment.email
    admin_email = post.user.email

    emails = []
    unless comment.email == admin_email
      emails << admin_email 
    end
    if post.invited_author && comment.email != post.invited_author.email
      emails << post.invited_author.email 
    end

    emails.join(" , ")
  end
end
