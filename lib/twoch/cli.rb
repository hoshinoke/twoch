require 'twoch'
require 'thor'

class Twoch
  class Cli < ::Thor
    desc "scan URL", "scan the url"
    option :referred, type: :boolean
    option :refering, type: :boolean
    option :from,     type: :numeric
    option :to,       type: :numeric
    option :image,    type: :boolean
    option :youtube,  type: :boolean
    def scan(url)
      Twoch.new.scan(url, options)
    end
  end
end
