describe Twoch::Query do
  it do
    expect(Twoch::Query.new).to be_a Twoch::Query
  end

  it do
    expect(Twoch::Query.new.query).to be_a Twoch::Query
  end
end
