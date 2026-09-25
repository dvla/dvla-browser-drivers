RSpec.describe DVLA::Browser::Drivers::SeleniumBuilder do
  subject { described_class }

  after do
    Capybara.reset_sessions!
    Capybara.instance_variable_set(:@session_pool, nil)
  end

  it 'registers a selenium_chrome driver' do
    selenium_driver = subject.new.build!
    expect(selenium_driver).to eq(:selenium_chrome)
    expect(Capybara.current_driver).to eq(:selenium_chrome)
  end

  it 'registers a selenium_firefox driver' do
    selenium_driver = subject.new(driver: :selenium, browser: :firefox).build!
    expect(selenium_driver).to eq(:selenium_firefox)
    expect(Capybara.current_driver).to eq(:selenium_firefox)
  end

  it 'registers a selenium_edge driver' do
    selenium_driver = subject.new(driver: :selenium, browser: :edge).build!
    expect(selenium_driver).to eq(:selenium_edge)
    expect(Capybara.current_driver).to eq(:selenium_edge)
  end

  it 'registers a selenium_safari driver' do
    selenium_driver = subject.new(driver: :selenium, browser: :safari).build!
    expect(selenium_driver).to eq(:selenium_safari)
    expect(Capybara.current_driver).to eq(:selenium_safari)
  end

  context 'method chaining through selenium_builder' do
    it 'registers a driver with headless true' do
      DVLA::Browser::Drivers.selenium_builder.headless.build!
      expect(Capybara.current_session.driver.options[:headless]).to eq(true)
    end

    it 'registers a driver with headless false' do
      DVLA::Browser::Drivers.selenium_builder.headed.build!
      expect(Capybara.current_session.driver.options[:headless]).to eq(false)
    end

    it 'registers a driver with javascript disabled' do
      DVLA::Browser::Drivers.selenium_builder.disable_javascript.build!
      expect(Capybara.current_session.driver.options[:browser_options]['blink-settings']).to eq('scriptEnabled=false')
    end

    it 'will override options if they contradict' do
      DVLA::Browser::Drivers.selenium_builder.headless.headed.build!
      expect(Capybara.current_session.driver.options[:headless]).to eq(false)
    end

    it 'raises an error if an invalid browser option is called' do
      expect { DVLA::Browser::Drivers.selenium_builder.ie.build! }.to raise_error(NoMethodError)
    end

    it "doesn't support browser_flags" do
      expect { DVLA::Browser::Drivers.cuprite_builder.add_browser_flag('my flag').build! }.to raise_error(NoMethodError)
    end

    it 'supports binary_path when browser is chrome' do
      DVLA::Browser::Drivers.selenium_builder.chrome.binary_path('my-path').build!
      expect(Capybara.current_session.driver.options[:options].binary).to eq('my-path')
    end

    it 'supports binary_path when browser is firefox' do
      DVLA::Browser::Drivers.selenium_builder.firefox.binary_path('my-path').build!
      expect(Capybara.current_session.driver.options[:options].binary).to eq('my-path')
    end

    it 'supports binary_path when browser is edge' do
      DVLA::Browser::Drivers.selenium_builder.edge.binary_path('my-path').build!
      expect(Capybara.current_session.driver.options[:options].binary).to eq('my-path')
    end

    # TODO: Need to figure out guards for safari
    # it "doesn't support binary_path when browser is safari" do
    #   DVLA::Browser::Drivers.selenium_builder.safari.binary_path('my-path').build!
    #   expect(Capybara.current_session.driver.options[:options].binary).to eq('my-path')
    # end

    it 'supports emulating devices' do
      DVLA::Browser::Drivers.selenium_builder.emulate_pixel_5.build!
      expect(Capybara.current_session.driver.options[:options].emulation[:user_agent]).to match(/Pixel 5/)
    end
  end
end
