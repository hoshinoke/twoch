require 'twoch'
require 'thor'

class Twoch
  class Cli < ::Thor
    desc "scan URL", "scan the url"
    option :"dry-run", type: :boolean
    def scan(url)
      Twoch.new.scan(url)
    end
  end
end
