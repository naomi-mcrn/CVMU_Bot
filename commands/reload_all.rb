lambda {
  cmdname = :reload_all
  MyBot::HELPS.update(cmdname => "全てのコマンドを再読み込みします。")
  MyBot.bot.command cmdname do |event|
    # begin command content
    msg = "reloading all command... "
    dmsg = ""
    reason = "unknown error."
    begin
      Dir.glob(Pathname.new(File.expand_path(File.dirname(__FILE__))).join("*")).each do |cmdfile|
        cmdname = cmdfile.match(/([0-9A-Za-z_-]+)\.rb/)[1]
        msg += "#{cmdname} "
        begin
          load cmdfile
        rescue => e
          msg += ": failed."
          raise e
        end
      end
      msg += ": success."
    rescue Exception => e
      dmsg = "<#{e.class}> #{e}"
    end
    # end command content
    Debug.log(event,msg + dmsg,cmdname)
    event.send_message(msg)
  end
}.call
