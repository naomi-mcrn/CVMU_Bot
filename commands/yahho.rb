lambda {
  cmdname = :yahho
  MyBot::HELPS.update(cmdname => "10秒後にやまびこを返します。")
  MyBot.bot.command cmdname do |event|
    # begin command content
    Debug.log(event,"deferring 10 seconds...",:yahho)
    sleep 10.0
    msg = "やっほー！#{event.user.mention}"
    # end command content
    Debug.log(event,msg,cmdname)
    event.send_message(msg)
  end
}.call
