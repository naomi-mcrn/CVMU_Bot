lambda {
  cmdname = :help
  MyBot::HELPS.update(cmdname => "使用可能なコマンドの一覧を表示します。")
  MyBot.bot.command cmdname do |event|
    # begin command content
    msg = "```使用可能コマンド一覧"
    MyBot::HELPS.sort.each do |cmd,descr|
      msg += "\n" + "#{cmd}#{' '*15}"[0,15] + "#{descr}"
    end
    msg += "```" 
    # end command content
    Debug.log(event,msg,cmdname)
    event.send_message(msg)
  end
}.call
