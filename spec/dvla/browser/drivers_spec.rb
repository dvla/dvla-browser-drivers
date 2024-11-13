RSpec.describe DVLA::Browser::Drivers do
  it 'has a version number' do
    expect(DVLA::Browser::Drivers::VERSION).not_to be nil
  end

  it 'can create a chrome driver' do
    DVLA::Browser::Drivers.selenium_chrome
    expect(Capybara.current_driver).to eq(:selenium_chrome)
  end

  it 'can create a firefox driver' do
    DVLA::Browser::Drivers.selenium_firefox
    expect(Capybara.current_driver).to eq(:selenium_firefox)
  end

  it 'can create an edge driver' do
    DVLA::Browser::Drivers.selenium_edge
    expect(Capybara.current_driver).to eq(:selenium_edge)
  end

  it 'can create a cuprite driver' do
    DVLA::Browser::Drivers.cuprite
    expect(Capybara.current_driver).to eq(:cuprite)
  end

  it 'can create an apparition driver' do
    DVLA::Browser::Drivers.apparition
    expect(Capybara.current_driver).to eq(:apparition)
  end

  it 'can create a headless chrome driver with standard options' do
    DVLA::Browser::Drivers.headless_selenium_chrome
    expect(Capybara.current_driver).to eq(:headless_selenium_chrome)

    args = Capybara.current_session.driver.options[:options].options[:args]

    expect(args).to include('--headless')
    expect(args).to include('--disable-dev-shm-usage')
    expect(args).to include('--no-sandbox')
  end

  it 'can create a headless firefox driver' do
    DVLA::Browser::Drivers.headless_selenium_firefox
    expect(Capybara.current_driver).to eq(:headless_selenium_firefox)
  end

  it 'can create a headless edge driver' do
    DVLA::Browser::Drivers.headless_selenium_edge
    expect(Capybara.current_driver).to eq(:headless_selenium_edge)
  end

  it 'can create a headless apparition driver' do
    DVLA::Browser::Drivers.headless_apparition
    expect(Capybara.current_driver).to eq(:headless_apparition)
  end

  it 'can create a headless cuprite driver with standard options' do
    DVLA::Browser::Drivers.headless_cuprite
    expect(Capybara.current_driver).to eq(:headless_cuprite)

    options = Capybara.current_session.driver.options

    expect(options[:headless]).to eq(true)
    expect(options[:timeout]).to eq(30)
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

    DVLA::Browser::Drivers.cuprite(timeout: 5)
    expect(Capybara.current_session.driver.options[:timeout]).to eq(5)
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
