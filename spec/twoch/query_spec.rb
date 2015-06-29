describe Twoch::Query do
  let(:twoch) { double(:twoch) }
  let(:query) { Twoch::Query.new(twoch) }

  describe 'query has no twoch' do
    let(:query) { Twoch::Query.new }
    it 'returns self' do
      expect(query.query).to be query
    end
  end

  describe 'query has a twoch' do
    it 'returns self' do
      reses = []
      expect(twoch).to receive(:reses).and_return(reses)
      expect(query.query).to be query
    end

    context 'given a hash' do
      it '#result returns the result' do
        hash = {from: 2}
        res_1 = double(:res_1, res_index: 1)
        res_2 = double(:res_2, res_index: 2)
        res_3 = double(:res_3, res_index: 3)
        reses = [res_1, res_2, res_3]
        expect(twoch).to receive(:reses).and_return(reses)
        expect(query.query(hash).result).to eq([res_2, res_3])
      end
    end
  end
end
