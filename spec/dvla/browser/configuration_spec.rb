RSpec.describe DVLA::Browser::Drivers::Configuration do
  subject { described_class.new }

  describe '#logger=' do
    it 'allows a custom logger to be passed in' do
      subject.logger = DVLA::Herodotus.logger('Browser Drivers')
      expect(subject.logger).to be_a(DVLA::Herodotus::HerodotusLogger)
    end

    it 'will warn if logger is set to something that is not a Logger' do
      expect { subject.logger = 'Something else' }.to output("[WARN] Custom logger is not an instance of Logger: 'String'\n").to_stderr
    end
  end

  describe '#logger' do
    it 'uses a standard logger by default' do
      expect(subject.logger).to be_a(Logger)
    end

    it 'will spawn a child logger if LOG already exists' do
      stub_const('LOG', DVLA::Herodotus.logger('My Test Pack'))
      # Need to clear previously initialised loggers so that we can make a fresh one to test child spawn logic
      DVLA::Browser::Drivers::instance_variable_set(:@logger, nil)
      DVLA::Browser::Drivers.config.instance_variable_set(:@logger, nil)

      expect(LOG).to receive(:spawn_child_logger).and_call_original
      DVLA::Browser::Drivers::SeleniumBuilder.new.build!
    end
  end
end
