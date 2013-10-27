class Doorlog
  def self.getRecent(last=5)
    client = Mysql2::Client.new(:host => "doorbox.hacklab.to",
                           :username => "touchscreen",
                           :database => "door")
    res = client.Query("select c.card_id, c.user, c.nick, a.entry_count from (select aa.id, aa.card_id, ab.entry_count from access_log aa join (select card_id, count(*) as entry_count from access_log group by card_id) ab on aa.card_id = ab.card_id ORDER BY aa.id DESC LIMIT 0,#{last}) as a join card c ON a.card_id = c.card_id ORDER BY a.id DESC")
    res.entries
  end
end

