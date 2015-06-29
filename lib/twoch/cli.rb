require 'twoch'
require 'thor'

class Twoch
  class Cli < ::Thor
    desc "scan URL", "scan the url"
    option :image,            type: :boolean
    option :youtube,          type: :boolean
    option :image_or_youtube, type: :boolean
    option :refs,             type: :boolean
    def scan(url)
      Twoch.new.scan(url, options)
    end
  end
end
