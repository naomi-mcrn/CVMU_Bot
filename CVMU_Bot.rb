require 'discordrb'
class Debug
  class << self
    def log(event,s,cmd)
      begin
        if event.nil?
          puts "[#{Time.now}]#{cmd.nil? ? nil : '<' + cmd.to_s + '>'}#{s}"
        else
          puts "[#{Time.now}]#{cmd.nil? ? nil : '<' + cmd.to_s + '>'}#{s}"
          puts "    user:#{event.user.name}##{event.user.discriminator}[#{event.user.id}]@#{event.server.name}"
          puts "    channel:#{event.channel.name}"
        end
      rescue => e
        puts "error on Debug.log! #{e}"
      end
    end
  end
end

class MyBot
  # TOKEN = nil
  HELPS = {}

  def self.bot
    @@bot ||= nil
    if @@bot.nil?
      @@bot = Discordrb::Commands::CommandBot.new(
        token: MyBot::TOKEN,
        prefix:'!',
      )
    end
    @@bot
  end

  def self.run
    bot = self.bot
    Dir.glob(Pathname.new(File.expand_path(File.dirname(__FILE__))).join("commands","*")).each do |cmdfile|
      cmdname = cmdfile.match(/([0-9A-Za-z_-]+)\.rb/)[1]
      msg = "loading command: #{cmdname}..."
      begin
        load cmdfile
        msg += "success."
      rescue => e
        msg += "failed. #{e}"
      end
      Debug.log(nil,msg,:bootsequence)
    end
    Dir.glob(Pathname.new(File.expand_path(File.dirname(__FILE__))).join("events","*")).each do |evtfile|
      msg = "loading events: #{evtfile}"
      begin
        load evtfile
        msg += "success."
      rescue
        msg += "failed. #{e}"
      end
      Debug.log(nil,msg,:bootsequence)
    end

    bot.run
  end

  private

  def initialize
  end

end

load 'token.rb'

MyBot.run
