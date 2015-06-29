class Twoch
  class Query
    def initialize(twoch = nil)
      @result = []
      @twoch  = twoch
    end

    attr_reader :result, :twoch

    def query(hash = {})
      if twoch
        result = twoch.reses.select do |res|
          (!hash[:from]      || hash[:from] <= res.res_index) \
          && \
          (!hash[:to]        || hash[:to] >= res.res_index) \
          && \
          (!hash[:image]     || res.image?) \
          && \
          (!hash[:youtube]   || res.youtube?)
        end

        self.result.replace(result)
      end

      self
    end
  end
end
