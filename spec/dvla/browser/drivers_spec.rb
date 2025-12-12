RSpec.describe DVLA::Browser::Drivers do
  it 'has a version number' do
    expect(DVLA::Browser::Drivers::VERSION).not_to be nil
  end

  it 'can create a Chrome driver' do
    DVLA::Browser::Drivers.selenium_chrome
    expect(Capybara.current_driver).to eq(:selenium_chrome)
  end

  it 'can create a Firefox driver' do
    DVLA::Browser::Drivers.selenium_firefox
    expect(Capybara.current_driver).to eq(:selenium_firefox)
  end

  it 'can create an Edge driver' do
    DVLA::Browser::Drivers.selenium_edge
    expect(Capybara.current_driver).to eq(:selenium_edge)
  end

  it 'can create a Safari driver' do
    DVLA::Browser::Drivers.selenium_safari
    expect(Capybara.current_driver).to eq(:selenium_safari)
  end

  it 'can create a Cuprite driver' do
    DVLA::Browser::Drivers.cuprite
    expect(Capybara.current_driver).to eq(:cuprite)
  end

  it 'can create an Apparition driver' do
    DVLA::Browser::Drivers.apparition
    expect(Capybara.current_driver).to eq(:apparition)
  end

  it 'can create a headless Chrome driver with standard options' do
    DVLA::Browser::Drivers.headless_selenium_chrome
    expect(Capybara.current_driver).to eq(:headless_selenium_chrome)

    args = Capybara.current_session.driver.options[:options].options[:args]

    expect(args).to include('--headless')
    expect(args).to include('--disable-dev-shm-usage')
    expect(args).to include('--no-sandbox')
  end

  it 'can create a headless Firefox driver' do
    DVLA::Browser::Drivers.headless_selenium_firefox
    expect(Capybara.current_driver).to eq(:headless_selenium_firefox)
  end

  it 'warns the user creating an Edge driver with headless configuration' do
    expect { DVLA::Browser::Drivers.headless_selenium_edge }.to output(/Edge does not support headless mode/).to_stdout_from_any_process
    expect(Capybara.current_driver).to eq(:headless_selenium_edge)
  end

  it 'warns the user creating a Safari driver with headless configuration' do
    expect { DVLA::Browser::Drivers.headless_selenium_safari }.to output(/Safari does not support headless mode/).to_stdout_from_any_process
    expect(Capybara.current_driver).to eq(:headless_selenium_safari)
  end

  it 'can create a headless Apparition driver' do
    DVLA::Browser::Drivers.headless_apparition
    expect(Capybara.current_driver).to eq(:headless_apparition)
  end

  it 'can create a headless Cuprite driver with standard options' do
    DVLA::Browser::Drivers.headless_cuprite
    expect(Capybara.current_driver).to eq(:headless_cuprite)

    options = Capybara.current_session.driver.options

    expect(options[:headless]).to eq(true)
    expect(options[:timeout]).to eq(60)
    expect(options.dig(:browser_options, :'disable-smooth-scrolling')).to eq(true)
  end

  it 'allows additional args to be passed' do
    DVLA::Browser::Drivers.selenium_chrome(remote: 'hello_world')
    expect(Capybara.current_session.driver.options[:url]).to eq('hello_world')
    expect(Capybara.current_session.driver.options[:browser]).to eq(:remote)

    DVLA::Browser::Drivers.selenium_firefox(additional_arguments: %w[headless])
    expect(Capybara.current_session.driver.options[:options].options[:args]).to include('--headless')

    DVLA::Browser::Drivers.selenium_edge(additional_preferences: [{ key: 'value' }])
    expect(Capybara.current_session.driver.options[:options].prefs).to include({ key: 'value' })

    DVLA::Browser::Drivers.cuprite(timeout: 5, browser_options: { something: 'blah' })
    expect(Capybara.current_session.driver.options.dig(:browser_options, :something)).to eq('blah')
  end

  it 'throws a NoMethodError when the method does not match regex' do
    expect { DVLA::Browser::Drivers.headless_blah }.to raise_error(NoMethodError)
  end

  it 'responds to method that matches regex' do
    expect(DVLA::Browser::Drivers.respond_to?(:selenium_chrome)).to be true
    expect(DVLA::Browser::Drivers.respond_to?(:selenium_edge)).to be true
    expect(DVLA::Browser::Drivers.respond_to?(:selenium_firefox)).to be true
    expect(DVLA::Browser::Drivers.respond_to?(:cuprite)).to be true
    expect(DVLA::Browser::Drivers.respond_to?(:apparition)).to be true

    expect(DVLA::Browser::Drivers.respond_to?(:headless_selenium_chrome)).to be true
    expect(DVLA::Browser::Drivers.respond_to?(:headless_selenium_edge)).to be true
    expect(DVLA::Browser::Drivers.respond_to?(:headless_selenium_firefox)).to be true
    expect(DVLA::Browser::Drivers.respond_to?(:headless_cuprite)).to be true
    expect(DVLA::Browser::Drivers.respond_to?(:headless_apparition)).to be true
  end
end
