describe Twoch::Body do
  it do
    expect(Twoch::Body.new).to be_a String
  end

  let(:body){ Twoch::Body.new('body') }

  it do
    expect(body).to eq('body')
  end
end
