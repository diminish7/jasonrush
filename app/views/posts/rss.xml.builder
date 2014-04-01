xml.instruct!

xml.rss "version" => "2.0" do
  xml.channel do
    xml.title get_title
    xml.link posts_angular_url(@blog)
    xml.description @blog.description || ""

    @blog.posts.ordered.each do |post|
      xml.item do
        xml.guid post_angular_url(post)
        xml.pubDate post.created_at.strftime("%a, %d %b %Y %k:%M:%S")
        xml.title post.title
        xml.link post_angular_url(post)
        xml.author post.author.try(:full_name) || ""
        xml.description post.body
      end
    end
  end
end
