require "twoch/line"
require "twoch/version"

class Twoch
  attr_accessor *%i(body lines url)

  class HTTPError < StandardError; end

  def get
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host)
    http.start do |http|
      res = http.get(uri.path + '?' + uri.query)
      @body = res.body
      if res.code.to_i >= 400
        raise HTTPError, res.class.to_s
      end
    end
  end

  def parse_lines
    self.lines = body.split("\n").map{|l| Res.new(l)}
  end
end
