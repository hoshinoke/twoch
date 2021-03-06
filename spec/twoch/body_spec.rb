describe Twoch::Body do
  it do
    expect(Twoch::Body.new).to be_a String
  end

  let(:body){ Twoch::Body.new('body') }

  it do
    expect(body).to eq('body')
    expect(body.image?).to be_falsy
    expect(body.youtube?).to be_falsy
    expect(body.ng?).to be_falsy
  end

  describe '#ng?' do
    let(:body_ng){ Twoch::Body.new("反日") }

    it do
      expect(body_ng).to receive(:ng_list).and_return(/反日|hogehoge/).at_least(1)
      expect(body_ng.ng?).to be true
    end
  end

  describe 'jpg' do
    let(:body_with_jpg){ Twoch::Body.new(" ttp://example.com/1.jpg ") }

    it do
      expect(body_with_jpg).to \
        eq("<img width=80 src='http://example.com/1.jpg'><br>")
    end

    context 'given width:400' do
      let(:body_with_jpg){ Twoch::Body.new(" ttp://example.com/1.jpg ", width: 400) }

      it do
        expect(body_with_jpg).to \
          eq("<img width=400 src='http://example.com/1.jpg'><br>")
      end
    end

    it do
      expect(body_with_jpg.image?).to be true
    end
  end

  describe 'ref' do
    let(:string) {'<a href="../test/abcdef/123" target="_blank">'}

    it do
      body_with_a = Twoch::Body.new(string)
      expect(body_with_a).to \
        eq(%(<a href=\"#res_article_123\">))
    end

    it 'calls res#add_ref(123)' do
      res = double(:res)

      expect(res).to receive(:add_ref).with(123)
      Twoch::Body.new(string, res: res)
    end
  end
end
