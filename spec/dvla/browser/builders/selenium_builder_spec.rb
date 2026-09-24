RSpec.describe DVLA::Browser::Drivers::SeleniumBuilder do
  subject { described_class }

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
end
