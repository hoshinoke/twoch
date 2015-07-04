class Twoch
  class Query
    def initialize(twoch = nil)
      @result = []
      @twoch  = twoch
    end

    attr_reader :result, :twoch

    def query(hash = {})
      if twoch
        result = twoch.reses

        result = result.select do |res|
          if hash[:refering_referred]
            [twoch.ref_table.values].flatten.include?(res.res_index) \
              || twoch.ref_table.key?(res.res_index)
          elsif hash[:referred]
            [twoch.ref_table.values].flatten.include?(res.res_index)
          else
            true
          end
        end

        result = result.select do |res|
          (!hash[:from]      || hash[:from] <= res.res_index) \
          && \
          (!hash[:to]        || hash[:to] >= res.res_index) \
        end

        result = result.select do |res|
          if hash[:image] && hash[:youtube]
            next(res.image? || res.youtube?)
          end

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
