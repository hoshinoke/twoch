class Twoch
  class Query
    def initialize(twoch = nil)
      @twoch = twoch
    end

    attr_reader :twoch

    def query
      twoch && twoch.reses
      self
    end
  end
end
