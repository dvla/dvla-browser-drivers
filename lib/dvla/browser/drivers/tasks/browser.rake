require 'capybara'
require 'dvla/browser/drivers'

DVLA_BROWSER_URL         = ENV.fetch('BROWSER_URL', 'http://localhost:3000').freeze
DVLA_BROWSER_PROXY_URL   = ENV.fetch('PROXY_URL', 'http://localhost:8080').freeze
DVLA_BROWSER_OPEN_TIME   = ENV.fetch('BROWSER_OPEN_TIME', 10).to_i
DVLA_BROWSER_WINDOW_SIZE = ENV.fetch('BROWSER_WINDOW_SIZE', '1337x800').then { |s| s.split('x').map(&:to_i) }.freeze
DVLA_BROWSER_MOBILE_PROFILES = DVLA::Browser::Drivers::MOBILE_PROFILES.keys

def dvla_browser_launch(driver_name, **)
  DVLA::Browser::Drivers.send(driver_name, **)
  session = Capybara::Session.new(driver_name)
  session.visit(DVLA_BROWSER_URL)
  sleep DVLA_BROWSER_OPEN_TIME
  # binding.irb
ensure
  session.quit
end

namespace :browser do
  # ── Selenium Chrome ───────────────────────────────────────────────────────────

  task(:selenium_chrome)                        { dvla_browser_launch(:selenium_chrome) }
  task(:headless_selenium_chrome)               { dvla_browser_launch(:headless_selenium_chrome) }
  task(:selenium_chrome_no_js)                  { dvla_browser_launch(:selenium_chrome_no_js) }
  task(:headless_selenium_chrome_no_js)         { dvla_browser_launch(:headless_selenium_chrome_no_js) }
  task(:selenium_chrome_proxied)                { dvla_browser_launch(:selenium_chrome_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_selenium_chrome_proxied)       { dvla_browser_launch(:headless_selenium_chrome_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_selenium_chrome_no_js_proxied) { dvla_browser_launch(:headless_selenium_chrome_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:selenium_chrome_emulated)               { dvla_browser_launch(:selenium_chrome, mobile_emulation: DVLA_BROWSER_MOBILE_PROFILES.sample) }
  task(:headless_selenium_chrome_emulated)      { dvla_browser_launch(:headless_selenium_chrome, mobile_emulation: DVLA_BROWSER_MOBILE_PROFILES.sample) }
  task(:selenium_chrome_window_size)            { dvla_browser_launch(:selenium_chrome, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  task(:headless_selenium_chrome_window_size)   { dvla_browser_launch(:headless_selenium_chrome, window_size: DVLA_BROWSER_WINDOW_SIZE) }

  # ── Selenium Firefox ──────────────────────────────────────────────────────────

  task(:selenium_firefox)                             { dvla_browser_launch(:selenium_firefox) }
  task(:headless_selenium_firefox)                    { dvla_browser_launch(:headless_selenium_firefox) }
  task(:selenium_firefox_no_js)                       { dvla_browser_launch(:selenium_firefox_no_js) }
  task(:headless_selenium_firefox_no_js)              { dvla_browser_launch(:headless_selenium_firefox_no_js) }
  task(:selenium_firefox_proxied)                     { dvla_browser_launch(:selenium_firefox_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_selenium_firefox_proxied)            { dvla_browser_launch(:headless_selenium_firefox_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_selenium_firefox_no_js_proxied)      { dvla_browser_launch(:headless_selenium_firefox_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:selenium_firefox_window_size)                 { dvla_browser_launch(:selenium_firefox, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  task(:headless_selenium_firefox_window_size)        { dvla_browser_launch(:headless_selenium_firefox, window_size: DVLA_BROWSER_WINDOW_SIZE) }

  # ── Selenium Edge ─────────────────────────────────────────────────────────────

  task(:selenium_edge)                          { dvla_browser_launch(:selenium_edge) }
  task(:headless_selenium_edge)                 { dvla_browser_launch(:headless_selenium_edge) }
  task(:selenium_edge_no_js)                    { dvla_browser_launch(:selenium_edge_no_js) }
  task(:headless_selenium_edge_no_js)           { dvla_browser_launch(:headless_selenium_edge_no_js) }
  task(:selenium_edge_proxied)                  { dvla_browser_launch(:selenium_edge_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_selenium_edge_proxied)         { dvla_browser_launch(:headless_selenium_edge_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_selenium_edge_no_js_proxied)   { dvla_browser_launch(:headless_selenium_edge_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:selenium_edge_emulated)                 { dvla_browser_launch(:selenium_edge, mobile_emulation: DVLA_BROWSER_MOBILE_PROFILES.sample) }
  task(:headless_selenium_edge_emulated)        { dvla_browser_launch(:headless_selenium_edge, mobile_emulation: DVLA_BROWSER_MOBILE_PROFILES.sample) }
  task(:selenium_edge_window_size)              { dvla_browser_launch(:selenium_edge, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  task(:headless_selenium_edge_window_size)     { dvla_browser_launch(:headless_selenium_edge, window_size: DVLA_BROWSER_WINDOW_SIZE) }

  # ── Selenium Safari ───────────────────────────────────────────────────────────

  task(:selenium_safari) { dvla_browser_launch(:selenium_safari) }

  # ── Cuprite ───────────────────────────────────────────────────────────────────

  task(:cuprite)                          { dvla_browser_launch(:cuprite) }
  task(:headless_cuprite)                 { dvla_browser_launch(:headless_cuprite) }
  task(:cuprite_no_js)                    { dvla_browser_launch(:cuprite_no_js) }
  task(:headless_cuprite_no_js)           { dvla_browser_launch(:headless_cuprite_no_js) }
  task(:cuprite_proxied)                  { dvla_browser_launch(:cuprite_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_cuprite_proxied)         { dvla_browser_launch(:headless_cuprite_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_cuprite_no_js_proxied)   { dvla_browser_launch(:headless_cuprite_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:cuprite_window_size)              { dvla_browser_launch(:cuprite, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  task(:headless_cuprite_window_size)     { dvla_browser_launch(:headless_cuprite, window_size: DVLA_BROWSER_WINDOW_SIZE) }

  # ── Apparition ────────────────────────────────────────────────────────────────

  task(:apparition)                           { dvla_browser_launch(:apparition) }
  task(:headless_apparition)                  { dvla_browser_launch(:headless_apparition) }
  task(:apparition_no_js)                     { dvla_browser_launch(:apparition_no_js) }
  task(:headless_apparition_no_js)            { dvla_browser_launch(:headless_apparition_no_js) }
  task(:apparition_proxied)                   { dvla_browser_launch(:apparition_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_apparition_proxied)          { dvla_browser_launch(:headless_apparition_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_apparition_no_js_proxied)    { dvla_browser_launch(:headless_apparition_no_js_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:apparition_window_size)               { dvla_browser_launch(:apparition, window_size: DVLA_BROWSER_WINDOW_SIZE) }
  task(:headless_apparition_window_size)      { dvla_browser_launch(:headless_apparition, window_size: DVLA_BROWSER_WINDOW_SIZE) }

  # ── Playwright ────────────────────────────────────────────────────────────────

  task(:playwright_chromium)                  { dvla_browser_launch(:playwright_chromium) }
  task(:headless_playwright_chromium)         { dvla_browser_launch(:headless_playwright_chromium) }
  task(:playwright_chromium_proxied)          { dvla_browser_launch(:playwright_chromium_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_playwright_chromium_proxied) { dvla_browser_launch(:headless_playwright_chromium_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:playwright_chromium_window_size)      { dvla_browser_launch(:playwright_chromium, window_size: DVLA_BROWSER_WINDOW_SIZE) }

  task(:playwright_firefox)                   { dvla_browser_launch(:playwright_firefox) }
  task(:headless_playwright_firefox)          { dvla_browser_launch(:headless_playwright_firefox) }
  task(:playwright_firefox_proxied)           { dvla_browser_launch(:playwright_firefox_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_playwright_firefox_proxied)  { dvla_browser_launch(:headless_playwright_firefox_proxied, proxy: DVLA_BROWSER_PROXY_URL) }

  task(:playwright_webkit)                    { dvla_browser_launch(:playwright_webkit) }
  task(:headless_playwright_webkit)           { dvla_browser_launch(:headless_playwright_webkit) }
  task(:playwright_webkit_proxied)            { dvla_browser_launch(:playwright_webkit_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
  task(:headless_playwright_webkit_proxied)   { dvla_browser_launch(:headless_playwright_webkit_proxied, proxy: DVLA_BROWSER_PROXY_URL) }
end
