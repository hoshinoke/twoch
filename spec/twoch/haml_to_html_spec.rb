describe Twoch::HamlToHtml do
  describe '#haml_to_html' do
    it do
      input = "%h1 aaa\n"
      output = Twoch::HamlToHtml.new.haml_to_html(input)
      expected = "<h1>aaa</h1>\n"
      expect(output).to eq(expected)
    end

    it do
      input = "%h1\n  = @value"
      locals = { :@value => 'hogehoge' }
      output = Twoch::HamlToHtml.new.haml_to_html(input, locals)

      expected = "<h1>\n  hogehoge\n</h1>\n"
      expect(output).to eq(expected)
    end
  end
end
