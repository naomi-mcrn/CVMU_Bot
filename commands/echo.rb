# -*- coding: utf-8 -*-
lambda {
  cmdname = :echo
  MyBot::HELPS.update(cmdname => "オウム返しします。")
  MyBot.bot.command cmdname do |event,*args|
    # begin command content
    msg = args.join(" ")
    # end command content
    Debug.log(event,msg,cmdname)
    event.send_message(msg)
  end
}.call
