describe Twoch::Res do
  it do
    expect(Twoch::Res.new).to be_a String
  end

  let(:line) { Twoch::Res.new('user<>meta<>time<>body<>title') }
  let(:line_with_b_tag) do
    Twoch::Res.new('user<b><>meta<b><>time<b><>body<b><>title<b>')
  end

  describe '#user' do
    it { expect(line.user).to eq('user') }
    it 'removes <b>' do
      expect(line_with_b_tag.user).to eq('user')
    end
  end

  describe '#meta' do
    it { expect(line.meta).to eq('meta') }
    it 'removes <b>' do
      expect(line_with_b_tag.meta).to eq('meta')
    end
  end

  describe '#time' do
    it { expect(line.time).to eq('time') }
    it 'removes <b>' do
      expect(line_with_b_tag.time).to eq('time')
    end
  end

  describe '#body' do
    it { expect(line.body).to eq('body') }
    it 'removes <b>' do
      expect(line_with_b_tag.body).to eq('body')
    end
  end

  describe '#title' do
    it { expect(line.title).to eq('title') }
    it 'removes <b>' do
      expect(line_with_b_tag.title).to eq('title')
    end
  end
end
