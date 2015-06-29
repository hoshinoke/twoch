describe Twoch::DatUri do
  describe '#convert' do
    it do
      input = 'http://anago.2ch.sc/test/read.cgi/geino/1370693658/'
      output = Twoch::DatUri.new.convert(input)
      expected = 'http://anago.2ch.sc/geino/dat/1370693658.dat'
      expect(output).to eq(expected)
    end
  end
end
