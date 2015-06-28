require "twoch/line"
require "twoch/version"

class Twoch
  attr_accessor :url
  attr_accessor :body
  attr_accessor :lines

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
    self.lines = body.split("\n").map{|l| Line.new(l)}
  end
end
