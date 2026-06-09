#!/usr/bin/env ruby
require 'webrick'
require 'webrick/httpproxy'
require 'dvla/herodotus'

# Serve our index.html over http to avoid any browser funny business when we visit a file://
# Run a proxy server on port 8080 to check browsers use it when configured.

class HerodotusWebrickLogger < WEBrick::Log
  LEVEL_MAP = {
    WEBrick::Log::DEBUG => :debug,
    WEBrick::Log::INFO  => :info,
    WEBrick::Log::WARN  => :warn,
    WEBrick::Log::ERROR => :error,
    WEBrick::Log::FATAL => :fatal,
  }.freeze

  def initialize(herodotus_logger)
    super(nil)
    @herodotus = herodotus_logger
  end

  def log(level, msg)
    @herodotus.public_send(LEVEL_MAP[level] || :info, msg.strip)
  end
end

class HerodotusAccessLog
  def initialize(herodotus_logger) = @herodotus = herodotus_logger

  def write(msg) = @herodotus.info(msg.strip)

  def <<(msg) = write(msg)

  def flush = nil
end

def build_logger(name, colour)
  config = Struct.new(*DVLA::Herodotus::CONFIG_ATTRIBUTES, keyword_init: true).new(
    prefix_colour: { system: [colour, 'bold'], level: [colour, 'bold'], date: %w[white], time: %w[white] },
  )
  DVLA::Herodotus.logger(name, config: config)
end

web_log   = build_logger('WEB',   'cyan')
proxy_log = build_logger('PROXY', 'magenta')

access_format = "%h - - [%t] \"%r\" %s %b\n"

web   = WEBrick::HTTPServer.new(Port: 3000, DocumentRoot: __dir__,
                                Logger: HerodotusWebrickLogger.new(web_log),
                                AccessLog: [[HerodotusAccessLog.new(web_log), access_format]])
proxy = WEBrick::HTTPProxyServer.new(Port: 8080,
                                     Logger: HerodotusWebrickLogger.new(proxy_log),
                                     AccessLog: [[HerodotusAccessLog.new(proxy_log), access_format]])

trap('INT')  { web.shutdown; proxy.shutdown }
trap('TERM') { web.shutdown; proxy.shutdown }

[Thread.new { web.start }, Thread.new { proxy.start }].each(&:join)
