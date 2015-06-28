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
end
