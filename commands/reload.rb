lambda {
  cmdname = :reload
  MyBot::HELPS.update(cmdname => "引数で指定したコマンドを再読み込みします。")
  MyBot.bot.command cmdname do |event,*args|
    # begin command content
    rcmdname = args[0].to_s.match(/([A-Za-z0-9_-]+)/)[1]
    msg = "reloading command: "
    dmsg = ""
    reason = "unknown error."
    begin
      if rcmdname.to_s.strip == ""
        reason = "bad argument."
        raise
      end
      msg += "#{rcmdname}..."
      basepath = Pathname.new(File.expand_path(File.dirname(__FILE__)))
      rcmdfile = basepath.join(rcmdname).to_s + ".rb"
      load rcmdfile
      msg += "success."
    rescue Exception => e
      if e.class == LoadError
        reason = "command not exist."
      end
      msg += "failed. #{reason}"
      dmsg = "<#{e.class}> #{e}, args = #{args}"
    end
    # end command content
    Debug.log(event,msg + dmsg,cmdname)
    event.send_message(msg)
  end
}.call
