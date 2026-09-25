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
  end
end
