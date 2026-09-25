RSpec.describe DVLA::Browser::Drivers::CupriteBuilder do
  subject { described_class }

  after do
    Capybara.reset_sessions!
    Capybara.instance_variable_set(:@session_pool, nil)
  end

  it 'registers a cuprite driver' do
    cuprite_driver = subject.new.register!
    expect(cuprite_driver).to eq(:cuprite)
    expect(Capybara.current_driver).to eq(:cuprite)
  end

  context 'method chaining through cuprite_builder' do
    it 'registers a driver with headless true' do
      DVLA::Browser::Drivers.cuprite_builder.headless.register!
      expect(Capybara.current_session.driver.options[:headless]).to eq(true)
    end

    it 'registers a driver with headless false' do
      DVLA::Browser::Drivers.cuprite_builder.headed.register!
      expect(Capybara.current_session.driver.options[:headless]).to eq(false)
    end

    it 'registers a driver with javascript disabled' do
      DVLA::Browser::Drivers.cuprite_builder.disable_javascript.register!
      expect(Capybara.current_session.driver.options[:browser_options]['blink-settings']).to eq('scriptEnabled=false')
    end

    it 'will override options if they contradict' do
      DVLA::Browser::Drivers.cuprite_builder.headless.headed.register!
      expect(Capybara.current_session.driver.options[:headless]).to eq(false)
    end

    it 'raises an error if an invalid browser option is called' do
      expect { DVLA::Browser::Drivers.cuprite_builder.chrome.register! }.to raise_error(NoMethodError)
    end

    it 'ignores browser_flags' do
      expect(DVLA::Browser::Drivers.logger).to receive(:warn)
      DVLA::Browser::Drivers.cuprite_builder.add_browser_flag('my flag').register!
    end

    it "doesn't support binary_path" do
      expect { DVLA::Browser::Drivers.cuprite_builder.binary_path('path').register! }.to raise_error(NoMethodError)
    end

    it "doesn't support emulating devices" do
      expect { DVLA::Browser::Drivers.cuprite_builder.emulate_pixel_5.register! }.to raise_error(NoMethodError)
    end
  end

  context 'passing in config' do
    # It has the right settings
    # It doesn't accept or ignores invalid options
  end
end
