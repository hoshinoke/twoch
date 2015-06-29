class Twoch
  class Body < ::String
    def initialize(arg, width: 240)
      super(arg.to_s)
      @width = width

      embed_img!
      embed_youtube!
      replace_a_tag!
    end

    attr_reader :width

    def embed_img!
      gsub!(%r{(\b|\s|h)ttp(s*)://\S+?\.(jpeg|jpg|jpg:large|png|gif|jpeg\?\S*|jpg\?\S*|png\?\S*|gif\?\S*)\s}) do |s|
        "<img width=#{width} src='#{s.gsub(/(^t|\st|ht)tp/, 'http').strip}'><br>"
      end
    end

    def embed_youtube!
      gsub!(%r{(\b|\s|h)ttp(s*)://www\.youtube\.com/\S+v=(\S+)\s}) do |s|
        "<iframe width='560' height='315' src='https://www.youtube.com/embed/#{$3}' frameborder='0' allowfullscreen></iframe>"
      end

      gsub!(%r{(\b|\s|h)ttp(s*)://youtu\.be/(\S+)\s}) do |s|
        "<iframe width='560' height='315' src='https://www.youtube.com/embed/#{$3}' frameborder='0' allowfullscreen></iframe>"
      end
    end

    def replace_a_tag!
      pattern = %r{<a href="\.\./test/.+/(\d+)" target="_blank">}
      gsub!(pattern) do
        # (@refs ||= []) << Regexp.last_match[1].to_i
        %(<a href="#res_article_#{Regexp.last_match[1]}">)
      end
    end
  end
end
