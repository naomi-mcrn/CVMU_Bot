# -*- coding: utf-8 -*-
require_relative '../vendor/lib/XP-RPC/xp'
lambda {
  def ppjson(jsonobj,indent=0)
    r = []
    ind = "  " * indent
    if jsonobj.is_a?(String)
      r = jsonobj.split("\n")
    elsif jsonobj.is_a?(Float)
      r = ["%.8f" % jsonobj]
    elsif jsonobj.is_a?(Numeric)
      r = [jsonobj.to_s]
    else
      jsonobj.each.map do |k,v|
        if v.is_a?(Hash)
          r.push("#{ind}#{k}:")
          r << ppjson(v,indent+1)
        elsif v.is_a?(Float)
        r.push("#{ind}#{k}: #{'%.8f' % v}")
        else
          r.push("#{ind}#{k}: #{v}")
        end
      end
    end
    r
  end

  cmdname = :xp
  MyBot::HELPS.update(cmdname => "XPdのラッパーです。")
  MyBot.bot.command cmdname do |event,*args|
    # begin command content
    rpccmd = ""
    begin
      res = nil
      rpccli = XP::RPC::Client.new("user" => MyBot::XP_RPC_USER, "pass" => MyBot::XP_RPC_PASS)
      if args && args.length >= 1
        rpccmd = args.shift
        rpcarg = []
        tmarg = nil
        args.each do |arg|
          if arg[0] = '"'
            tmarg = arg[1,arg.length-1]
          else
            if tmarg
              tmarg += " #{arg}"
              if arg[-1] = '"'
                tmarg.chop!
                rpcarg.push(tmarg)
              end
            else
              rpcarg.push(arg)
            end
          end
        end
        rpcres = rpccli.execrpc(rpccmd,*rpcarg)
        Debug.log(event,"raw result of RPC",cmdname)
        Debug.log(event,rpcres.to_json,cmdname)
        if rpcres["result"]
          res = ppjson(rpcres["result"])
        else
          res = ppjson(rpcres["error"])
        end
      end
  
     
      buf = []
      sz = 0
      res.each do |line|
        buf.push(line)
        sz += line.length
        if sz > 1000
          msg = buf.join("\n")
          event.send_message("```#{msg}```")
          buf = []
          sz = 0
        end
      end
      if sz > 0
        msg = buf.join("\n")
        event.send_message("```#{msg}```")
      end
      msg = "executed #{rpccmd} successfully."
    rescue Exception => e
      msg = "executed #{rpccmd}... oops, error! #{e.class} #{e}"
    end
    # end command content
    Debug.log(event,msg,cmdname)
  end
}.call
