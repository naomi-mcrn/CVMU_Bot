lambda {
  cmdname = :test
  MyBot::HELPS.update(cmdname => "テストです。")
  MyBot.bot.command cmdname do |event|
    # begin command content
    msg = "テストです。現在 #{Time.now} です。"
    # end command content
    Debug.log(event,msg,cmdname)
    event.send_message(msg)
  end
}.call
