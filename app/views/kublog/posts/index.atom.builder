atom_feed do |feed|
  feed.title    @presenter.title
  feed.updated  @presenter.updated
  @presenter.posts.each do |post|
    feed.entry(post) do |entry|
      entry.link(:href => post.url)
      entry.title       post.title
      entry.content     post.body, :type => 'html'
      entry.author do |author|
        author.name post.user.to_s
      end
    end
  end
end