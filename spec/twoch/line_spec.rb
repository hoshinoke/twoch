describe Twoch::Line do
  it do
    expect(Twoch::Line.new).to be_a String
  end

  let(:line) { Twoch::Line.new('user<>meta<>time<>body<>title') }

  describe '#user' do
    it { expect(line.user).to eq('user') }
  end

  describe '#meta' do
    it { expect(line.meta).to eq('meta') }
  end

  describe '#time' do
    it { expect(line.time).to eq('time') }
  end

  describe '#body' do
    it { expect(line.body).to eq('body') }
  end

  describe '#title' do
    it { expect(line.title).to eq('title') }
  end
end
