require "nkf"
require "twoch/body"
require "twoch/dat_uri"
require "twoch/haml_to_html"
require "twoch/query"
require "twoch/res"
require "twoch/version"

class Twoch
  attr_accessor *%i(body reses url)

  class HTTPError < StandardError; end

  def scan(url, options = nil)
    set_url(url)
    get
    parse_reses
    do_query(options)
    puts rendered
  end

  def query
    @query ||= Query.new(self)
  end

  def query_result
    @query_result ||= []
  end

  def get
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host)
    http.start do |http|
      res = http.get(uri.path + '?' + uri.query.to_s)
      @body = NKF.nkf('-Lu, --utf8', res.body)
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

  def set_url(url)
    self.url = DatUri.new.convert(url)
  end

  def do_query(options = {})
    query_result.replace(query.query(options).result)
  end

  def rendered
    haml_string = File.read(template_path)
    html_string = HamlToHtml.new.haml_to_html(haml_string, locals)
    add_more(html_string)
  end

  def add_more(string)
    replaced  = %(</div>\n\n<div)
    replacing = %(</div><a name="more"></a><div)
    string.sub(replaced, replacing)
  end

  def template_path
    File.join(File.dirname(__FILE__), '../template/main.haml')
  end

  def locals
    { :@reses => query_result }
  end
end
