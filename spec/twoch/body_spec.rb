describe Twoch::Body do
  it do
    expect(Twoch::Body.new).to be_a String
  end

  let(:body){ Twoch::Body.new('body') }

  it do
    expect(body).to eq('body')
  end

  describe 'jpg' do
    let(:body_with_jpg){ Twoch::Body.new(" ttp://example.com/1.jpg ") }

    it do
      expect(body_with_jpg).to \
        eq("<img width=240 src='http://example.com/1.jpg'><br>")
    end
  end

  describe 'ref' do
    it do
      string = '<a href="../test/abcdef/123" target="_blank">'
      body_with_a = Twoch::Body.new(string, res: double(:res, add_ref: nil))
      expect(body_with_a).to \
        eq(%(<a href=\"#res_article_123\">))
    end
  end
end
