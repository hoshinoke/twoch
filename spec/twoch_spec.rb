describe Twoch do
  it 'has a version number' do
    expect(Twoch::VERSION).not_to be nil
  end

  describe '.new' do
    it do
      expect(Twoch.new).to be_a Twoch
    end
  end

  let(:twoch) { Twoch.new }

  describe '#url=' do
    context 'given a String' do
      it 'sets the url to url' do
        twoch.url = 'hogehoge url'
        expect(twoch.url).to eq('hogehoge url')
      end
    end
  end

  describe '#scan' do
    it 'calls all methods' do
      expect(twoch).to receive(:set_url).with('url')
      expect(twoch).to receive(:get)
      expect(twoch).to receive(:parse_reses)
      expect(twoch).to receive(:do_query)
      expect(twoch).to receive(:rendered).and_return('<html></html>')
      expect(STDOUT).to receive(:puts).with('<html></html>')
      twoch.scan('url')
    end
  end

  describe '#get' do
    describe 'send a GET request' do
      before do
        WebMock.stub_request(:get, 'http://example.com/1?x=y')
        .to_return(body: '<h1>body</h1>', status: status)
        twoch.url = 'http://example.com/1?x=y'
      end

      context 'when the responses 200' do
        let(:status) { 200 }

        it 'response body is set to @body' do
          twoch.get
          expect(twoch.body).to eq('<h1>body</h1>')
        end
      end

      context 'when the responses 404' do
        let(:status) { 404 }

        it 'raises' do
          expect { twoch.get }.to \
            raise_error(Twoch::HTTPError, 'Net::HTTPNotFound')
        end
      end
    end
  end

  describe '#parse_reses' do
    it do
      twoch.body = "a\nb\n"
      twoch.parse_reses
      expect(twoch.reses).to eq(%w(a b))
      expect(twoch.reses).to all(be_a Twoch::Res)
      expect(twoch.reses.first.res_index).to be 1
    end
  end

  describe '#add_ref' do
  end

  describe '#ref_table' do
  end

  describe '#set_url' do
    it do
      expect_any_instance_of(Twoch::DatUri).to \
        receive(:convert).with(:fugafuga).and_return(:hogehoge)
      twoch.set_url(:fugafuga)
      expect(twoch.url).to be :hogehoge
    end
  end

  describe '#do_query' do
    it do
      result = double(:result, result: [:hogehoge])

      expect(twoch.query).to receive(:query).with(image: true).and_return(result)
      expect { twoch.do_query }.to \
        change { twoch.query_result }.from([]).to([:hogehoge])
    end
  end
end
