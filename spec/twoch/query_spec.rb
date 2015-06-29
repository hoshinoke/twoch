describe Twoch::Query do
  let(:query) { Twoch::Query.new }
  it do
    expect(query.query).to be query
  end
end
