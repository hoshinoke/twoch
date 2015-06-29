require 'haml'
require 'haml/exec'


class Twoch
  class HamlToHtml
    # コンバータ。
    def haml_to_html(string, locals = {})
      Haml::Engine.new(string).render(binding, locals)
    end
  end
end
