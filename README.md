# DVLA::Browser::Drivers

DVLA-Browser-Drivers is a gem that has pre-configured browser drivers that you can use out-of-the-box for the
development of your application.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dvla-browser-drivers'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dvla-browser-drivers

## Usage

Once installed, you are able to use any pre-configured browser driver from the list below:

### Selenium drivers

| Driver           | Usage                                         |
|------------------|-----------------------------------------------|
| selenium_chrome  | `DVLA::Browser::Drivers.selenium_chrome`      |
| selenium_firefox | `DVLA::Browser::Drivers.selenium_firefox`     |
| selenium_edge    | `DVLA::Browser::Drivers.selenium_edge`        |
| selenium_safari  | `DVLA::Browser::Drivers.selenium_safari`      |

### Non-selenium drivers

| Driver     | Usage                               |
|------------|-------------------------------------|
| cuprite    | `DVLA::Browser::Drivers.cuprite`    |
| apparition | `DVLA::Browser::Drivers.apparition` |

### Driver modifiers

The following modifiers can be applied to any driver above (except selenium_safari):

| Modifier    | Example                                             | Description                                                                   |
|-------------|-----------------------------------------------------|-------------------------------------------------------------------------------|
| headless_   | `headless_selenium_chrome`                          | Runs the browser in headless mode                                             |
| _no_js      | `selenium_chrome_no_js`                             | Disables JavaScript in the browser                                            |
| _proxied    | `selenium_firefox_proxied(proxy: 'http://foo.bar')` | Routes traffic through a proxy, requires a url passed as the `proxy` argument |

Modifiers can be combined, e.g. `headless_selenium_firefox_no_js_proxied`

**Note:** selenium_safari does not support any modifiers.

---

### Default configuration

[Chromium switches](https://peter.sh/experiments/chromium-command-line-switches/)

| Driver                                           | Configuration                                         |
|--------------------------------------------------|-------------------------------------------------------|
| selenium_chrome, selenium_edge, selenium_firefox | --disable-dev-shm-usage<br/>                          |
| headless\_<driver>                               | --headless<br/>--no-sandbox                           |
| cuprite, apparition                              | { 'no-sandbox': nil, disable-smooth-scrolling: true } |

---

### Additional configuration

[Cuprite Documentation](https://www.rubydoc.info/gems/cuprite/)
[Selenium Additional Preferences Documentation](https://www.selenium.dev/selenium/docs/api/rb/Selenium/WebDriver/Chromium/Options.html#add_preference-instance_method)

| Option                 | Driver                               | Usage                                                                                           | Description                                |
|------------------------|--------------------------------------|-------------------------------------------------------------------------------------------------|--------------------------------------------|
| remote                 | Selenium, Cuprite, Apparition        | `selenium_chrome(remote: 'http://localhost:4444/wd/hub')`                                       | Allows you to talk to a remote browser     |
| additional_arguments   | Selenium                             | `selenium_chrome(additional_arguments: ['window-size=1400,1920'] `                              | Pass additional arguments to the driver    |
| additional_preferences | Selenium                             | `selenium_chrome(additional_preferences: [{'download.default_directory': '<download_path>'}] )` | Pass additional preferences to the driver  |
| proxy                  | Selenium, Cuprite                    | `selenium_firefox_proxied(proxy: 'http://proxy:8080')`                                          | Sets the proxy URL for proxied drivers     |
| window_size            | Chrome, Edge, Cuprite, Apparition    | `selenium_chrome(window_size: [1400, 900])`                                                     | Sets the browser window size. Accepts an array `[w, h]` or a string `'1400x900'`. Not supported on Firefox, Edge or Safari |
| timeout                | Cuprite, Apparition                  | `cuprite(timeout: 60 )`                                                                         | Sets the default timeout for the driver    |
| save_path              | Cuprite, Apparition                  | `cuprite(save_path: 'File.expand_path('./somewhere')' )`                                        | Tells the browser where to store downloads |
| browser_options        | Cuprite, Apparition                  | `cuprite(browser_options: { option: value, option: value })`                                    | Pass additional options to the browser     |

---

### BiDi Support

BiDi (Bidirectional Protocol) is enabled by default on all Selenium drivers (Chrome, Firefox, Edge). This allows bidirectional communication between the driver and browser.
It is still in active development so breaking changes are expected. Check the documentation for the latest implementation guides:

* [Selenium docs](https://www.selenium.dev/documentation/webdriver/bidi/)
* [W3C specification](https://w3c.github.io/webdriver-bidi/)


## Rake Tasks

The gem ships with a set of rake tasks to quickly launch any driver against a URL for manual inspection.
Add the following to your `Rakefile` to make them available:

```ruby
require 'dvla/browser/drivers/tasks'
```

Then run any `browser:*` task, e.g.:

```bash
bundle exec rake browser:selenium_chrome
bundle exec rake browser:headless_cuprite
```

The following environment variables can be used to configure the tasks:

| Variable            | Default                  | Description                              |
|---------------------|--------------------------|------------------------------------------|
| `BROWSER_URL`       | `http://localhost:3000`  | URL the browser will open                |
| `PROXY_URL`         | `http://localhost:8080`  | Proxy URL for `_proxied` tasks           |
| `BROWSER_OPEN_TIME` | `10`                     | Seconds to hold the browser open         |
| `BROWSER_WINDOW_SIZE` | `1337x800`             | Window size for `_window_size` tasks     |

---

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).
