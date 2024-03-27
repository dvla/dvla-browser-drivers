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

| Driver           | Usage                                     |
| ---------------- | ----------------------------------------- |
| chrome           | `DVLA::Browser::Drivers.chrome`           |
| headless_chrome  | `DVLA::Browser::Drivers.headless_chrome`  |
| edge             | `DVLA::Browser::Drivers.edge`             |
| headless_edge    | `DVLA::Browser::Drivers.headless_edge`    |
| firefox          | `DVLA::Browser::Drivers.firefox`          |
| headless_firefox | `DVLA::Browser::Drivers.headless_firefox` |

### Non-selenium drivers

| Driver              | Usage                                        |
| ------------------- | -------------------------------------------- |
| cuprite             | `DVLA::Browser::Drivers.cuprite`             |
| headless_cuprite    | `DVLA::Browser::Drivers.headless_cuprite`    |
| apparition          | `DVLA::Browser::Drivers.apparition`          |
| headless_apparition | `DVLA::Browser::Drivers.headless_apparition` |

---

### Default configuration

| Driver                | Configuration                                         |
| --------------------- | ----------------------------------------------------- |
| chrome, edge, firefox | --disable-dev-shm-usage<br/>                          |
| headless\_<driver>    | --headless<br/>--no-sandbox                           |
| cuprite, apparition   | { 'no-sandbox': nil, disable-smooth-scrolling: true } |

---

### Additional configuration

| Option                                                                      | Description                                                                                                                                                                        | supported-browsers    |
| --------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| remote: 'http://localhost:4444/wd/hub'                                      | Allows you to talk to a remote browser                                                                                                                                             | firefox               |
| additional_options: ['window-size=1400,1920']                               | Pass additional options to the driver<br/>Supported switches: https://peter.sh/experiments/chromium-command-line-switches/                                                         | chrome, edge, firefox |
| additional_preferences: [{'download.default_directory': '<download_path>'}] | Pass additional preferences to the driver<br/>Documentation: https://www.selenium.dev/selenium/docs/api/rb/Selenium/WebDriver/Chromium/Options.html#add_preference-instance_method | chrome, edge, firefox |
| additional_options: { 'option': value, 'option': value }                    | Pass additional options to the driver<br/>Supported switched: https://www.rubydoc.info/gems/cuprite/                                                                               | cuprite, apparition   |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).
