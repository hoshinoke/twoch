require 'spec_helper'

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

  describe '#get' do
    describe 'send a GET request' do
      context 'when the responses 200' do
        it 'response body is set to @body' do
          WebMock.stub_request(:get, 'http://example.com/1?x=y')
          .to_return(body: '<h1>body</h1>')

          twoch.url = 'http://example.com/1?x=y'
          twoch.get
          expect(twoch.body).to eq('<h1>body</h1>')
        end
      end

      context 'when the responses 404' do
        it 'raises' do
          WebMock.stub_request(:get, 'http://example.com/1?x=y')
          .to_return(body: '<h1>404</h1>', status: 404)

          twoch.url = 'http://example.com/1?x=y'
          expect { twoch.get }.to \
            raise_error(Twoch::HTTPError, 'Net::HTTPNotFound')
        end
      end
    end
  end
end
