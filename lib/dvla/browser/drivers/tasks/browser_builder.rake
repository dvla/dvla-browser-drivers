require 'capybara'
require 'dvla/browser/drivers'

DVLA_BROWSER_URL = ENV.fetch('BROWSER_URL', 'http://localhost:3000').freeze
DVLA_BROWSER_PROXY_URL = ENV.fetch('PROXY_URL', 'http://localhost:8080').freeze
DVLA_BROWSER_OPEN_TIME = ENV.fetch('BROWSER_OPEN_TIME', 10).to_i
DVLA_BROWSER_WINDOW_SIZE = ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800').then { |s| s.split('x').map(&:to_i) }.freeze
DVLA_BROWSER_MOBILE_PROFILES = DVLA::Browser::Drivers::MOBILE_PROFILES.keys

def build_and_launch_browser(builder)
  driver_name = builder.register!

  session = Capybara::Session.new(driver_name)
  session.visit(DVLA_BROWSER_URL)

  sleep DVLA_BROWSER_OPEN_TIME
ensure
  session.quit
end

namespace :browser_builder do
  # ── Selenium Chrome ───────────────────────────────────────────────────────────

  desc 'Launch Chrome'
  task(chrome: 'browser_builder:chrome:default')

  namespace :chrome do
    builder = DVLA::Browser::Drivers.selenium_builder.chrome.headed

    desc 'Launch Chrome'
    task(:default) { build_and_launch_browser(builder) }

    desc 'Launch Chrome (headless)'
    task(:headless) { build_and_launch_browser(builder.headless) }

    desc 'Launch Chrome (no JS)'
    task(:disable_js) { build_and_launch_browser(builder.disable_javascript) }

    desc 'Launch Chrome (headless, no JS)'
    task(:headless_disable_js) { build_and_launch_browser(builder.headless.disable_javascript) }

    desc 'Launch Chrome (proxied)'
    task(:proxied) { build_and_launch_browser(builder.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc 'Launch Chrome (headless, proxied)'
    task(:headless_proxied) { build_and_launch_browser(builder.headless.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc 'Launch Chrome (headless, no JS, proxied)'
    task(:headless_disable_js_proxied) { build_and_launch_browser(builder.headless.disable_javascript.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc "Launch Chrome at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:window_size) { build_and_launch_browser(builder.window_size(height: 1337, width: 800)) }

    desc "Launch Chrome (headless) at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:headless_window_size) { build_and_launch_browser(builder.headless.window_size(height: 1337, width: 800)) }

    desc 'Launch Chrome with mobile emulation'
    task(:emulated) { build_and_launch_browser(builder.send("emulate_#{DVLA_BROWSER_MOBILE_PROFILES.sample}")) }

    desc 'Launch Chrome (headless) with mobile emulation'
    task(:headless_emulated) { build_and_launch_browser(builder.headless.send("emulate_#{DVLA_BROWSER_MOBILE_PROFILES.sample}")) }
  end

  # ── Selenium Firefox ──────────────────────────────────────────────────────────

  desc 'Launch Firefox'
  task(firefox: 'browser:firefox:default')

  namespace :firefox do
    builder = DVLA::Browser::Drivers.selenium_builder.firefox.headed

    desc 'Launch Firefox'
    task(:default) { build_and_launch_browser(builder) }

    desc 'Launch Firefox (headless)'
    task(:headless) { build_and_launch_browser(builder.headless) }

    desc 'Launch Firefox (no JS)'
    task(:no_js) { build_and_launch_browser(builder.disable_javascript) }

    desc 'Launch Firefox (headless, no JS)'
    task(:headless_no_js) { build_and_launch_browser(builder.headless.disable_javascript) }

    desc 'Launch Firefox (proxied)'
    task(:proxied) { build_and_launch_browser(builder.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc 'Launch Firefox (headless, proxied)'
    task(:headless_proxied) { build_and_launch_browser(builder.headless.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc 'Launch Firefox (headless, no JS, proxied)'
    task(:headless_no_js_proxied) { build_and_launch_browser(builder.headless.disable_javascript.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc "Launch Firefox at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:window_size) { build_and_launch_browser(builder.window_size(height: 1337, width: 800)) }

    desc "Launch Firefox (headless) at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:headless_window_size) { build_and_launch_browser(builder.headless.window_size(height: 1337, width: 800)) }
  end

  # ── Selenium Edge ─────────────────────────────────────────────────────────────

  desc 'Launch Edge'
  task(edge: 'browser:edge:default')

  namespace :edge do
    builder = DVLA::Browser::Drivers.selenium_builder.edge.headed

    desc 'Launch Edge'
    task(:default) { build_and_launch_browser(builder) }

    desc 'Launch Edge (headless)'
    task(:headless) { build_and_launch_browser(builder.headless) }

    desc 'Launch Edge (no JS)'
    task(:no_js) { build_and_launch_browser(builder.disable_javascript) }

    desc 'Launch Edge (headless, no JS)'
    task(:headless_no_js) { build_and_launch_browser(builder.headless.disable_javascript) }

    desc 'Launch Edge (proxied)'
    task(:proxied) { build_and_launch_browser(builder.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc 'Launch Edge (headless, proxied)'
    task(:headless_proxied) { build_and_launch_browser(builder.headless.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc 'Launch Edge (headless, no JS, proxied)'
    task(:headless_no_js_proxied) { build_and_launch_browser(builder.headless.disable_javascript.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc 'Launch Edge with mobile emulation'
    task(:emulated) { build_and_launch_browser(builder.emulate_device(DVLA_BROWSER_MOBILE_PROFILES.sample)) }

    desc 'Launch Edge (headless) with mobile emulation'
    task(:headless_emulated) { build_and_launch_browser(builder.headless.emulate_device(DVLA_BROWSER_MOBILE_PROFILES.sample)) }

    desc "Launch Edge at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:window_size) { build_and_launch_browser(builder.window_size(height: 1337, width: 800)) }

    desc "Launch Edge (headless) at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:headless_window_size) { build_and_launch_browser(builder.headless.window_size(height: 1337, width: 800)) }
  end

  # ── Selenium Safari ───────────────────────────────────────────────────────────

  desc 'Launch Safari'
  task(safari: 'browser:safari:default')

  namespace :safari do
    builder = DVLA::Browser::Drivers.selenium_builder.safari.headed

    desc 'Launch Safari'
    task(:default) { build_and_launch_browser(builder) }
  end

  # ── Cuprite ───────────────────────────────────────────────────────────────────

  desc 'Launch Cuprite'
  task(cuprite: 'browser:cuprite:default')

  namespace :cuprite do
    builder = DVLA::Browser::Drivers.cuprite_builder.headed

    desc 'Launch Cuprite'
    task(:default) { build_and_launch_browser(builder) }

    desc 'Launch Cuprite (headless)'
    task(:headless) { build_and_launch_browser(builder.headless) }

    desc 'Launch Cuprite (no JS)'
    task(:disable_js) { build_and_launch_browser(builder.disable_javascript) }

    desc 'Launch Cuprite (headless, no JS)'
    task(:headless_disable_js) { build_and_launch_browser(builder.headless.disable_javascript) }

    desc 'Launch Cuprite (proxied)'
    task(:proxied) { build_and_launch_browser(builder.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc 'Launch Cuprite (headless, proxied)'
    task(:headless_proxied) { build_and_launch_browser(builder.headless.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc 'Launch Cuprite (headless, no JS, proxied)'
    task(:headless_disable_js_proxied) { build_and_launch_browser(builder.headless.disable_javascript.proxy_url(DVLA_BROWSER_PROXY_URL)) }

    desc "Launch Cuprite at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:window_size) { build_and_launch_browser(builder.window_size(height: 1337, width: 800)) }

    desc "Launch Cuprite (headless) at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:headless_window_size) { build_and_launch_browser(builder.headless.window_size(height: 1337, width: 800)) }
  end
end
