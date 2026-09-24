RSpec.describe DVLA::Browser::Drivers::Builder do
  subject { described_class }

  it 'raises an error if build! is called' do
    expect { subject.new.build! }.to raise_error(DVLA::Browser::Drivers::Builder::DriverNotImplementedError) do |error|
      expect(error.message).to eq('Use a specific builder class')
    end
  end
end
