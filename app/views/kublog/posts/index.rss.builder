xml.instruct! :xml, :version => "1.0", :encoding => 'UTF-8'
xml.rss :version => "2.0", 'xmlns:dc' => "http://purl.org/dc/elements/1.1/", 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.tag!("atom:link", :rel => 'self', :href => atom_url(@presenter))
    xml.title @presenter.title
    xml.description @presenter.description
    xml.link root_url
    @presenter.posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.updated_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
        xml.category post.category.to_s if post.category
        xml.tag! "dc:creator", post.author
      end
    end
  end
end