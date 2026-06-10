require 'capybara'
require 'dvla/browser/drivers'

DVLA_BROWSER_URL         = ENV.fetch('BROWSER_URL', 'http://localhost:3000').freeze
DVLA_BROWSER_PROXY_URL   = ENV.fetch('PROXY_URL', 'http://localhost:8080').freeze
DVLA_BROWSER_OPEN_TIME   = ENV.fetch('BROWSER_OPEN_TIME', 10).to_i
DVLA_BROWSER_WINDOW_SIZE = ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800').then { |s| s.split('x').map(&:to_i) }.freeze
DVLA_BROWSER_MOBILE_PROFILES = DVLA::Browser::Drivers::MOBILE_PROFILES.keys

def dvla_browser_launch(driver_name, **opts)
  DVLA::Browser::Drivers.send(driver_name, **opts)
  session = Capybara::Session.new(driver_name)
  session.visit(DVLA_BROWSER_URL)
  sleep DVLA_BROWSER_OPEN_TIME
ensure
  session.quit
end

namespace :browser do
  # ── Selenium Chrome ───────────────────────────────────────────────────────────

  desc 'Launch Chrome'
  task(chrome: 'browser:chrome:default')

  namespace :chrome do
    desc 'Launch Chrome'
    task(:default) { dvla_browser_launch(:selenium_chrome) }
    desc 'Launch Chrome (headless)'
    task(:headless) { dvla_browser_launch(:headless_selenium_chrome) }
    desc 'Launch Chrome (no JS)'
    task(:no_js) { dvla_browser_launch(:selenium_chrome_no_js) }
    desc 'Launch Chrome (headless, no JS)'
    task(:headless_no_js) { dvla_browser_launch(:headless_selenium_chrome_no_js) }
    desc 'Launch Chrome (proxied)'
    task(:proxied) { dvla_browser_launch(:selenium_chrome_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Chrome (headless, proxied)'
    task(:headless_proxied) { dvla_browser_launch(:headless_selenium_chrome_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Chrome (headless, no JS, proxied)'
    task(:headless_no_js_proxied) { dvla_browser_launch(:headless_selenium_chrome_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Chrome with mobile emulation'
    task(:emulated) { dvla_browser_launch(:selenium_chrome, emulate_device: DVLA_BROWSER_MOBILE_PROFILES.sample) }
    desc 'Launch Chrome (headless) with mobile emulation'
    task(:headless_emulated) { dvla_browser_launch(:headless_selenium_chrome, emulate_device: DVLA_BROWSER_MOBILE_PROFILES.sample) }
    desc "Launch Chrome at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:window_size) { dvla_browser_launch(:selenium_chrome, window_size: DVLA_BROWSER_WINDOW_SIZE) }
    desc "Launch Chrome (headless) at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:headless_window_size) { dvla_browser_launch(:headless_selenium_chrome, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  end

  # ── Selenium Firefox ──────────────────────────────────────────────────────────

  desc 'Launch Firefox'
  task(firefox: 'browser:firefox:default')

  namespace :firefox do
    desc 'Launch Firefox'
    task(:default) { dvla_browser_launch(:selenium_firefox) }
    desc 'Launch Firefox (headless)'
    task(:headless) { dvla_browser_launch(:headless_selenium_firefox) }
    desc 'Launch Firefox (no JS)'
    task(:no_js) { dvla_browser_launch(:selenium_firefox_no_js) }
    desc 'Launch Firefox (headless, no JS)'
    task(:headless_no_js) { dvla_browser_launch(:headless_selenium_firefox_no_js) }
    desc 'Launch Firefox (proxied)'
    task(:proxied) { dvla_browser_launch(:selenium_firefox_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Firefox (headless, proxied)'
    task(:headless_proxied) { dvla_browser_launch(:headless_selenium_firefox_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Firefox (headless, no JS, proxied)'
    task(:headless_no_js_proxied) { dvla_browser_launch(:headless_selenium_firefox_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc "Launch Firefox at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:window_size) { dvla_browser_launch(:selenium_firefox, window_size: DVLA_BROWSER_WINDOW_SIZE) }
    desc "Launch Firefox (headless) at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:headless_window_size) { dvla_browser_launch(:headless_selenium_firefox, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  end

  # ── Selenium Edge ─────────────────────────────────────────────────────────────

  desc 'Launch Edge'
  task(edge: 'browser:edge:default')

  namespace :edge do
    desc 'Launch Edge'
    task(:default) { dvla_browser_launch(:selenium_edge) }
    desc 'Launch Edge (headless)'
    task(:headless) { dvla_browser_launch(:headless_selenium_edge) }
    desc 'Launch Edge (no JS)'
    task(:no_js) { dvla_browser_launch(:selenium_edge_no_js) }
    desc 'Launch Edge (headless, no JS)'
    task(:headless_no_js) { dvla_browser_launch(:headless_selenium_edge_no_js) }
    desc 'Launch Edge (proxied)'
    task(:proxied) { dvla_browser_launch(:selenium_edge_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Edge (headless, proxied)'
    task(:headless_proxied) { dvla_browser_launch(:headless_selenium_edge_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Edge (headless, no JS, proxied)'
    task(:headless_no_js_proxied) { dvla_browser_launch(:headless_selenium_edge_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Edge with mobile emulation'
    task(:emulated) { dvla_browser_launch(:selenium_edge, emulate_device: DVLA_BROWSER_MOBILE_PROFILES.sample) }
    desc 'Launch Edge (headless) with mobile emulation'
    task(:headless_emulated)    { dvla_browser_launch(:headless_selenium_edge, emulate_device: DVLA_BROWSER_MOBILE_PROFILES.sample) }
    desc "Launch Edge at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:window_size)          { dvla_browser_launch(:selenium_edge, window_size: DVLA_BROWSER_WINDOW_SIZE) }
    desc "Launch Edge (headless) at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:headless_window_size) { dvla_browser_launch(:headless_selenium_edge, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  end

  # ── Selenium Safari ───────────────────────────────────────────────────────────

  desc 'Launch Safari'
  task(safari: 'browser:safari:default')

  namespace :safari do
    desc 'Launch Safari'
    task(:default) { dvla_browser_launch(:selenium_safari) }
  end

  # ── Cuprite ───────────────────────────────────────────────────────────────────

  desc 'Launch Cuprite'
  task(cuprite: 'browser:cuprite:default')

  namespace :cuprite do
    desc 'Launch Cuprite'
    task(:default) { dvla_browser_launch(:cuprite) }
    desc 'Launch Cuprite (headless)'
    task(:headless) { dvla_browser_launch(:headless_cuprite) }
    desc 'Launch Cuprite (no JS)'
    task(:no_js) { dvla_browser_launch(:cuprite_no_js) }
    desc 'Launch Cuprite (headless, no JS)'
    task(:headless_no_js) { dvla_browser_launch(:headless_cuprite_no_js) }
    desc 'Launch Cuprite (proxied)'
    task(:proxied) { dvla_browser_launch(:cuprite_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Cuprite (headless, proxied)'
    task(:headless_proxied) { dvla_browser_launch(:headless_cuprite_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Cuprite (headless, no JS, proxied)'
    task(:headless_no_js_proxied) { dvla_browser_launch(:headless_cuprite_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc "Launch Cuprite at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:window_size) { dvla_browser_launch(:cuprite, window_size: DVLA_BROWSER_WINDOW_SIZE) }
    desc "Launch Cuprite (headless) at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:headless_window_size) { dvla_browser_launch(:headless_cuprite, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  end

  # ── Apparition ────────────────────────────────────────────────────────────────

  desc 'Launch Apparition'
  task(apparition: 'browser:apparition:default')

  namespace :apparition do
    desc 'Launch Apparition'
    task(:default) { dvla_browser_launch(:apparition) }
    desc 'Launch Apparition (headless)'
    task(:headless)             { dvla_browser_launch(:headless_apparition) }
    desc 'Launch Apparition (no JS)'
    task(:no_js)                { dvla_browser_launch(:apparition_no_js) }
    desc 'Launch Apparition (headless, no JS)'
    task(:headless_no_js) { dvla_browser_launch(:headless_apparition_no_js) }
    desc 'Launch Apparition (proxied)'
    task(:proxied) { dvla_browser_launch(:apparition_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Apparition (headless, proxied)'
    task(:headless_proxied) { dvla_browser_launch(:headless_apparition_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc 'Launch Apparition (headless, no JS, proxied)'
    task(:headless_no_js_proxied) { dvla_browser_launch(:headless_apparition_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    desc "Launch Apparition at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:window_size) { dvla_browser_launch(:apparition, window_size: DVLA_BROWSER_WINDOW_SIZE) }
    desc "Launch Apparition (headless) at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
    task(:headless_window_size) { dvla_browser_launch(:headless_apparition, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  end

  # ── Playwright ────────────────────────────────────────────────────────────────

  namespace :playwright do
    desc 'Launch Playwright Chromium'
    task(chromium: 'browser:playwright:chromium:default')
    desc 'Launch Playwright Firefox'
    task(firefox: 'browser:playwright:firefox:default')
    desc 'Launch Playwright WebKit'
    task(webkit: 'browser:playwright:webkit:default')

    namespace :chromium do
      desc 'Launch Playwright Chromium'
      task(:default)          { dvla_browser_launch(:playwright_chromium) }
      desc 'Launch Playwright Chromium (headless)'
      task(:headless)         { dvla_browser_launch(:headless_playwright_chromium) }
      desc 'Launch Playwright Chromium (proxied)'
      task(:proxied)          { dvla_browser_launch(:playwright_chromium_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
      desc 'Launch Playwright Chromium (headless, proxied)'
      task(:headless_proxied) { dvla_browser_launch(:headless_playwright_chromium_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
      desc "Launch Playwright Chromium at window size #{ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800')}"
      task(:window_size)      { dvla_browser_launch(:playwright_chromium, window_size: DVLA_BROWSER_WINDOW_SIZE) }
    end

    namespace :firefox do
      desc 'Launch Playwright Firefox'
      task(:default)          { dvla_browser_launch(:playwright_firefox) }
      desc 'Launch Playwright Firefox (headless)'
      task(:headless)         { dvla_browser_launch(:headless_playwright_firefox) }
      desc 'Launch Playwright Firefox (proxied)'
      task(:proxied)          { dvla_browser_launch(:playwright_firefox_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
      desc 'Launch Playwright Firefox (headless, proxied)'
      task(:headless_proxied) { dvla_browser_launch(:headless_playwright_firefox_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    end

    namespace :webkit do
      desc 'Launch Playwright WebKit'
      task(:default)          { dvla_browser_launch(:playwright_webkit) }
      desc 'Launch Playwright WebKit (headless)'
      task(:headless)         { dvla_browser_launch(:headless_playwright_webkit) }
      desc 'Launch Playwright WebKit (proxied)'
      task(:proxied)          { dvla_browser_launch(:playwright_webkit_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
      desc 'Launch Playwright WebKit (headless, proxied)'
      task(:headless_proxied) { dvla_browser_launch(:headless_playwright_webkit_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
    end
  end
end
