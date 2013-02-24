class NewsFeed < ActiveRecord::Base

  def rss
    @parsed_feed ||= SimpleRSS.parse open self.url
  end

  def items
    rss.items.map do |item|
      NewsFeedItem.new rss.channel, item
    end
  end

  def self.getAllArticles(top=5)
    articles=[]
    self.all.each do |feed|
      feed.items.first(top).each do |item|
         articles << item.getArticle
      end
    end
    articles.shuffle
  end
end
