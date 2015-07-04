describe Twoch::Res do
  it do
    expect(Twoch::Res.new).to be_a String
  end

  let(:res) { Twoch::Res.new('user<>meta<>time<>body<>title') }
  let(:res_with_b_tag) do
    Twoch::Res.new('user<b><>meta<b><>time<b><>body<b><>title<b>')
  end

  describe '#user' do
    it { expect(res.user).to eq('user') }
    it 'removes <b>' do
      expect(res_with_b_tag.user).to eq('user')
    end
  end

  describe '#meta' do
    it { expect(res.meta).to eq('meta') }
    it 'removes <b>' do
      expect(res_with_b_tag.meta).to eq('meta')
    end
  end

  describe '#time' do
    it { expect(res.time).to eq('time') }
    it 'removes <b>' do
      expect(res_with_b_tag.time).to eq('time')
    end
  end

  describe '#body' do
    it { expect(res.body).to eq('body') }
    it { expect(res.body).to be_a Twoch::Body }
    it 'removes <b>' do
      expect(res_with_b_tag.body).to eq('body')
    end
  end

  describe '#title' do
    it { expect(res.title).to eq('title') }
    it 'removes <b>' do
      expect(res_with_b_tag.title).to eq('title')
    end
  end

  describe '#res_index' do
    let(:res) { Twoch::Res.new('', index: 2) }
    it { expect(res.res_index).to be 2 }
  end

  describe '#ng?' do
    it 'returns same object as body#ng?' do
      expect(res.body).to receive(:ng?).and_return(:bool)
      expect(res.ng?).to be :bool
    end
  end

  describe '#image?' do
    it 'returns same object as body#image?' do
      expect(res.body).to receive(:image?).and_return(:bool)
      expect(res.image?).to be :bool
    end
  end

  describe '#youtube?' do
    it 'returns same object as body#youtube?' do
      expect(res.body).to receive(:youtube?).and_return(:bool)
      expect(res.youtube?).to be :bool
    end
  end
end
