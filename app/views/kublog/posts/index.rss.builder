xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.tag!("atom:link", 'xmlns:atom' => 'http://www.w3.org/2005/Atom', 
             :rel => 'hub', :href => atom_url(@presenter))
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
      end
    end
  end
end