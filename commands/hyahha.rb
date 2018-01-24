lambda {
  cmdname = :hyahha
  MyBot::HELPS.update(cmdname => "世紀末な挨拶を返します。")
  MyBot.bot.command cmdname do |event|
    # begin command content
    msg = "ヒャッハー！#{event.user.mention}、汚物は消毒だー！！！"
    # end command content
    Debug.log(event,msg,cmdname)
    event.send_message(msg)
  end
}.call