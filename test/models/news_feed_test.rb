require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class NewsFeedTest < Test::Unit::TestCase
  context "NewsFeed Model" do
    should 'construct new instance' do
      @news_feed = NewsFeed.new
      assert_not_nil @news_feed
    end
  end
end
