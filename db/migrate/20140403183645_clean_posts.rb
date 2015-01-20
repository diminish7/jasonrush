class CleanPosts < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      doc = Nokogiri::HTML::DocumentFragment.parse(post.body)
      clean_node(doc)
      post.update_column(:body, doc.to_html)
    end
  end

  def down
    # NOOP
  end

private
  def clean_node(node)
    node.children.each do |child|
      case child
      when Nokogiri::XML::Text
        # Get rid of empty text nodes
        child.remove if child.text.blank?
      when Nokogiri::XML::Element
        # Get rid of any built in styles
        child.attributes['style'].try(:remove)
        if child.name == "div"
          # Recurse on divs
          clean_node(child)
          if child.children.blank?
            # Remove empty elements
            child.remove
          elsif child.children.none? { |c| c.name == "p" }
            # As long as this isn't wrapping other paragraphs, make it a paragraph
            child.name = "p"
          end
        end
      end
    end
  end
end
