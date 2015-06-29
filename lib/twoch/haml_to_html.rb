require 'haml'
require 'haml/exec'


class Twoch
  class HamlToHtml
    # コンバータ。
    def haml_to_html(string)
      Haml::Engine.new(string).render
    end
  end
end
