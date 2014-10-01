class NewsFeedItem
  def initialize(channel, item)
    @channel = channel
    @item = item
  end

  def getArticle
    desc = description.slice(0,150);
    if desc.length > 147
      desc[147..150]="..."
    end
    {
      title: title,
      content: description,
      source: source,
      description: desc
    }
  end

  def title
    Sanitize.clean @item.title
  end

  def source
    Sanitize.clean @channel.title
  end

  def description
    Sanitize.clean "#{@item.description}"
  end
end
