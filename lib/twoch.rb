require "twoch/body"
require "twoch/dat_uri"
require "twoch/haml_to_html"
require "twoch/query"
require "twoch/res"
require "twoch/version"
require "pry"

class Twoch
  attr_accessor *%i(body reses url)

  class HTTPError < StandardError; end

  def scan(url)
    self.url = url
    get
    parse_reses
  end

  def get
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host)
    http.start do |http|
      res = http.get(uri.path + '?' + uri.query.to_s)
      @body = res.body
      if res.code.to_i >= 400
        raise HTTPError, res.class.to_s
      end
    end
  end

  def parse_reses
    self.reses = body.split("\n").map.with_index(1) do |line, i|
      Res.new(line, index: i, twoch: self)
    end
  end

  def add_ref(from:, to:)
    ref_table[from].push(to).uniq!
  end

  def ref_table
    @ref_table ||= Hash.new{|hash, key| hash[key] = []}
  end
end
