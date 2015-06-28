require "twoch/version"

class Twoch
  attr_accessor :url
  attr_reader :body

  def get
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host)
    http.start do |http|
      res = http.get(uri.path + '?' + uri.query)
      @body = res.body
    end
  end
end
