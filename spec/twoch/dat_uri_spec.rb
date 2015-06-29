describe Twoch::DatUri do
  describe '#convert' do
    it do
      actual = Twoch::DatUri.new.convert('')
      expect(actual).to eq('')
    end
  end
end
