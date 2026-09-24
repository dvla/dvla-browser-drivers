RSpec.describe DVLA::Browser::Drivers::CupriteBuilder do
  subject { described_class }

  it 'registers a cuprite driver' do
    cuprite_driver = subject.new.build!
    expect(cuprite_driver).to eq(:cuprite)
    expect(Capybara.current_driver).to eq(:cuprite)
  end
end
