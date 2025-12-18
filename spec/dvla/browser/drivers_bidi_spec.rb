# frozen_string_literal: true

RSpec.describe 'DVLA::Browser::Drivers BiDi Support' do
  %i[headless_selenium_chrome headless_selenium_firefox selenium_edge].each do |driver|
    describe "BiDi functionality with #{driver}", :bidi_integration do
      skip 'Edge WebDriver not available in CI' if driver == :selenium_edge && ENV['CI']
      before do
        DVLA::Browser::Drivers.send(driver)
        Capybara.current_driver = driver
      end

      after do
        Capybara.reset_sessions!
        Capybara.instance_variable_set(:@session_pool, nil)
      end

      it 'provides BiDi instance by default' do
        session = Capybara.current_session
        session.visit('data:text/html,<h1>Test</h1>')

        expect { session.driver.browser.bidi }.not_to raise_error
        expect(session.driver.browser.bidi).to respond_to(:send_cmd)
      end

      it 'can execute BiDi commands' do
        session = Capybara.current_session
        session.visit('data:text/html,<h1>Initial</h1>')

        bidi = session.driver.browser.bidi
        result = bidi.send_cmd('session.status')

        expect(result).to have_key('ready')
        expect(result['ready']).to be(false)
      end

      it 'can get browsing context information' do
        session = Capybara.current_session
        session.visit('data:text/html,<h1>Test</h1>')
        bidi = session.driver.browser.bidi
        result = bidi.send_cmd('browsingContext.getTree')

        expect(result).to have_key('contexts')
        expect(result['contexts']).to be_an(Array)
        expect(result['contexts'].first).to have_key('context')
      end
    end
  end
end
