# -*- coding: utf-8 -*-
lambda {
  MyBot.bot.message(contains: "文鳥") do |event|
    catch(:breakcmd) do
      throw :breakcmd if event.message.author.bot_account?
      Debug.log(event,"buncho message invoked.","buncho")
      if /文鳥.*(へふへふ|なめなめ|ぺろぺろ|ｐｒｐｒ|prpr)/ =~ event.content
        event.respond "ぷぐー！！\n#{event.user.mention}は腹痛になった！"
        Debug.log(event,"buncho puguu","buncho")
      end
    end
  end
}.call
