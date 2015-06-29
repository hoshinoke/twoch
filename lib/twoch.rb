require "twoch/body"
require "twoch/query"
require "twoch/res"
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
    self.lines = body.split("\n").map.with_index do |line, i|
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
