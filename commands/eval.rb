# -*- coding: utf-8 -*-
lambda {
  cmdname = :eval
  MyBot::HELPS.update(cmdname => "コードを実行します（危険！）。")
  MyBot.bot.command cmdname do |event,*code|
    # begin command content
    if event.user.id != MyBot::OWNER_DISCORD_ID
      msg = "#{event.user.mention}、あなたはこのコマンドを使用する権限がありません！"
    end
    begin
      msg = "#{eval code.join(' ')}"
    rescue Exception => e
      msg = "oops, error!: #{e.class} #{e}"
    end
    # end command content
    Debug.log(event,msg,cmdname)
    event.send_message(msg)
  end
}.call
