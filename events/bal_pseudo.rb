# -*- coding: utf-8 -*-
lambda {
  MyBot.bot.message(start_with: ",") do |event|
    catch(:breakcmd) do
      throw :breakcmd if event.message.author.bot_account?
      if /,balance / =~ event.content || event.content == ",balance"
        event.respond "#{event.user.mention} ここはbalanceする場所じゃねぇっつってんだろこのスッダボがぁぁ！！"
        Debug.log(event,"invoked pseudo balance command.",",balance")
      end
    end
  end
}.call
