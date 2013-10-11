xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0", "xmlns:atom" => "http://www.w3.org/2005/Atom" do
  xml.channel do
    xml.title "PaulBarry.com"
    xml.link "http://paulbarry.com"
    xml.atom :link, href: "http://feeds.feedburner.com/paulbarry", rel: "self", type: "application/rss+xml"
    xml.description "My thoughts, ideas, questions and concerns on technology"
    for article in @articles
      xml.item do
        xml.author "mail@paulbarry.com (Paul Barry)"
        xml.title article.title
        xml.description article.formatted_body
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link article_url(article.permalink_params)
        xml.guid "urn:uuid:#{article.guid}", isPermaLink: "false"
      end
    end
  end
end
