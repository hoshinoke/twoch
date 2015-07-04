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
      let(:res_1){ double(:res_1, res_index: 1) }
      let(:res_2){ double(:res_2, res_index: 2) }
      let(:res_3){ double(:res_3, res_index: 3) }
      let(:res_4){ double(:res_4, res_index: 4) }
      let(:res_5){ double(:res_5, res_index: 5) }
      let(:reses){ [res_1, res_2, res_3, res_4, res_5] }

      it '#result returns the result' do
        hash = {}
        expect(twoch).to receive(:reses).and_return(reses)
        expect(query.query(hash).result).to eq([res_1, res_2, res_3, res_4, res_5])
      end

      it '#result returns the result' do
        hash = {from: 2}
        expect(twoch).to receive(:reses).and_return(reses)
        expect(query.query(hash).result).to eq([res_2, res_3, res_4, res_5])
      end

      it '#result returns the result' do
        hash = {from: 2, to: 4}
        expect(twoch).to receive(:reses).and_return(reses)
        expect(query.query(hash).result).to eq([res_2, res_3, res_4])
      end
    end

    context 'given a hash' do
      let(:res_1){ double(:res_1, image?: true, youtube?: true) }
      let(:res_2){ double(:res_2, image?: nil,  youtube?: true) }
      let(:res_3){ double(:res_3, image?: nil,  youtube?: nil ) }
      let(:res_4){ double(:res_4, image?: nil,  youtube?: nil ) }
      let(:res_5){ double(:res_5, image?: true, youtube?: nil ) }
      let(:reses){ [res_1, res_2, res_3, res_4, res_5] }

      it '#result returns the result' do
        hash = {image: true}
        expect(twoch).to receive(:reses).and_return(reses)
        expect(query.query(hash).result).to eq([res_1, res_5])
      end

      it '#result returns the result' do
        hash = {youtube: true}
        expect(twoch).to receive(:reses).and_return(reses)
        expect(query.query(hash).result).to eq([res_1, res_2])
      end

      it '#result returns the result' do
        hash = {image: true, youtube: true}
        expect(twoch).to receive(:reses).and_return(reses)
        expect(query.query(hash).result).to eq([res_1, res_2, res_5])
      end
    end

    context 'given a hash' do
      let(:res_1){ double(:res_1, res_index: 1) }
      let(:res_2){ double(:res_2, res_index: 2) }
      let(:res_3){ double(:res_3, res_index: 3) }
      let(:res_4){ double(:res_4, res_index: 4) }
      let(:res_5){ double(:res_5, res_index: 5) }
      let(:reses){ [res_1, res_2, res_3, res_4, res_5] }

      it '#result returns the result' do
        hash = {referred: true}
        ref_table = {
          100 => [1],
          200 => [1, 2],
          300 => [2, 4, 50],
        }
        expect(twoch).to receive(:ref_table).and_return(ref_table).at_least(1)
        expect(twoch).to receive(:reses).and_return(reses)
        expect(query.query(hash).result).to eq([res_1, res_2, res_4])
      end

      it '#result returns the result' do
        hash = {refering_referred: true}
        ref_table = {
          100 => [1],
          200 => [1, 2],
          3   => [1],
        }
        expect(twoch).to receive(:ref_table).and_return(ref_table).at_least(1)
        expect(twoch).to receive(:reses).and_return(reses)
        expect(query.query(hash).result).to eq([res_1, res_2, res_3])
      end
    end
  end
end
