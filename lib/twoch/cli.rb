require 'twoch'
require 'thor'

class Twoch
  class Cli < ::Thor
    desc "scan URL", "scan the url"
    option :image,             type: :boolean
    option :youtube,           type: :boolean
    option :referred,          type: :boolean
    option :refering,          type: :boolean
    def scan(url)
      Twoch.new.scan(url, options)
    end
  end
end
