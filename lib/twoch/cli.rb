require 'twoch'
require 'thor'

class Twoch
  class Cli < ::Thor
    desc "scan URL", "scan the url"
    option :"dry-run", type: :boolean
    option :image, type: :boolean
    def scan(url)
      Twoch.new.scan(url, options)
    end
  end
end
