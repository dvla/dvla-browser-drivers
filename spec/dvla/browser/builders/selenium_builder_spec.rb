RSpec.describe DVLA::Browser::Drivers::SeleniumBuilder do
  subject { described_class }

  after do
    Capybara.reset_sessions!
    Capybara.instance_variable_set(:@session_pool, nil)
  end

  it 'registers a selenium_chrome driver' do
    selenium_driver = subject.new.register!
    expect(selenium_driver).to eq(:selenium_chrome)
    expect(Capybara.current_driver).to eq(:selenium_chrome)
  end

  it 'registers a selenium_firefox driver' do
    selenium_driver = subject.new(driver: :selenium, browser: :firefox).register!
    expect(selenium_driver).to eq(:selenium_firefox)
    expect(Capybara.current_driver).to eq(:selenium_firefox)
  end

  it 'registers a selenium_edge driver' do
    selenium_driver = subject.new(driver: :selenium, browser: :edge).register!
    expect(selenium_driver).to eq(:selenium_edge)
    expect(Capybara.current_driver).to eq(:selenium_edge)
  end

  it 'registers a selenium_safari driver' do
    selenium_driver = subject.new(driver: :selenium, browser: :safari).register!
    expect(selenium_driver).to eq(:selenium_safari)
    expect(Capybara.current_driver).to eq(:selenium_safari)
  end

  context 'method chaining through selenium_builder' do
    it 'registers a selenium_chrome driver' do
      DVLA::Browser::Drivers.selenium_builder.chrome.register!
      expect(Capybara.current_driver).to eq(:selenium_chrome)
    end

    it 'registers a selenium_firefox driver' do
      DVLA::Browser::Drivers.selenium_builder.firefox.register!
      expect(Capybara.current_driver).to eq(:selenium_firefox)
    end

    it 'registers a selenium_edge driver' do
      DVLA::Browser::Drivers.selenium_builder.edge.register!
      expect(Capybara.current_driver).to eq(:selenium_edge)
    end

    it 'registers a selenium_safari driver' do
      DVLA::Browser::Drivers.selenium_builder.safari.register!
      expect(Capybara.current_driver).to eq(:selenium_safari)
    end

    it 'registers a driver with headless true' do
      DVLA::Browser::Drivers.selenium_builder.headless.register!
      expect(Capybara.current_session.driver.options[:options].args).to include('--headless')
    end

    it 'registers a driver with headless false' do
      DVLA::Browser::Drivers.selenium_builder.headed.register!
      expect(Capybara.current_session.driver.options[:options].args).to_not include('--headless')
    end

    it 'registers a driver with javascript disabled' do
      DVLA::Browser::Drivers.selenium_builder.disable_javascript.register!
      expect(Capybara.current_session.driver.options[:options].prefs['profile.managed_default_content_settings.javascript']).to eq(2)
    end

    it 'registers a driver with a remote host' do
      DVLA::Browser::Drivers.selenium_builder.remote_host('example.com').register!
      expect(Capybara.current_session.driver.options[:url]).to eq('example.com')
    end

    it 'registers a driver with a proxy url' do
      DVLA::Browser::Drivers.selenium_builder.proxy_url('proxy.com').register!
      expect(Capybara.current_session.driver.options[:options].args).to include('--proxy-server=proxy.com')
    end

    it 'will override options if they contradict' do
      DVLA::Browser::Drivers.selenium_builder.headless.headed.register!
      expect(Capybara.current_session.driver.options[:options].args).to_not include('--headless')
    end

    it 'raises an error if an invalid browser option is called' do
      expect { DVLA::Browser::Drivers.selenium_builder.ie.register! }.to raise_error(NoMethodError)
    end

    it 'supports binary_path when browser is chrome' do
      DVLA::Browser::Drivers.selenium_builder.chrome.binary_path('my-path').register!
      expect(Capybara.current_session.driver.options[:options].binary).to eq('my-path')
    end

    it 'supports binary_path when browser is firefox' do
      DVLA::Browser::Drivers.selenium_builder.firefox.binary_path('my-path').register!
      expect(Capybara.current_session.driver.options[:options].binary).to eq('my-path')
    end

    it 'supports binary_path when browser is edge' do
      DVLA::Browser::Drivers.selenium_builder.edge.binary_path('my-path').register!
      expect(Capybara.current_session.driver.options[:options].binary).to eq('my-path')
    end

    it 'ignores binary_path when browser is safari' do
      expect(DVLA::Browser::Drivers.logger).to receive(:warn)
      DVLA::Browser::Drivers.selenium_builder.safari.binary_path('my-path').register!
      expect { Capybara.current_session.driver.options[:options].binary }.to raise_error(NoMethodError)
    end

    it 'supports emulating devices when browser is chrome' do
      DVLA::Browser::Drivers.selenium_builder.chrome.emulate(:iphone_15_pro_max).register!
      expect(Capybara.current_session.driver.options[:options].emulation[:user_agent]).to match(/iPhone/)
      expect(Capybara.current_session.driver.options[:options].emulation[:device_metrics][:width]).to eq(430)
      expect(Capybara.current_session.driver.options[:options].emulation[:device_metrics][:height]).to eq(739)
    end

    it 'supports emulating devices when browser is edge' do
      DVLA::Browser::Drivers.selenium_builder.edge.emulate(:pixel_5).register!
      expect(Capybara.current_session.driver.options[:options].emulation[:user_agent]).to match(/Pixel 5/)
      expect(Capybara.current_session.driver.options[:options].emulation[:device_metrics][:width]).to eq(393)
      expect(Capybara.current_session.driver.options[:options].emulation[:device_metrics][:height]).to eq(851)
    end

    it "doesn't support emulating devices when browser is firefox" do
      expect { DVLA::Browser::Drivers.selenium_builder.firefox.emulate(:pixel_5).register! }.to raise_error(DVLA::Browser::Drivers::SeleniumBuilder::BrowserNotSupportedError)
    end

    it "doesn't support emulating devices when browser is safari" do
      expect { DVLA::Browser::Drivers.selenium_builder.safari.emulate(:pixel_5).register! }.to raise_error(DVLA::Browser::Drivers::SeleniumBuilder::BrowserNotSupportedError)
    end

    it 'raises an error if emulate is called with a device that is not supported' do
      expect { DVLA::Browser::Drivers.selenium_builder.chrome.emulate(:lg_g2).register! }.to raise_error(ArgumentError)
    end
  end
end
