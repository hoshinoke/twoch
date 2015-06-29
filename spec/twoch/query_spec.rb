describe Twoch::Query do
  let(:query) { Twoch::Query.new }
  it do
    expect(query.query).to be query
  end

  describe 'given query stuff' do
    let(:twoch) { double(:twoch) }
    let(:query) { Twoch::Query.new(twoch) }

    it do
      reses = []
      expect(twoch).to receive(:reses).and_return(reses)
      expect(query.query).to be query
    end
  end
end
