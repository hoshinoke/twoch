class Twoch
  class Query
    def initialize(twoch = nil)
      @result = []
      @twoch  = twoch
    end

    attr_reader :result, :twoch

    def query(hash = {})
      return self if !twoch
      result = twoch.reses

      result = filter_refer(result, hash)

      result = filter_from_to(result, hash)

      result = filter_image_youtube(result, hash)

      self.result.replace(result)

      self
    end

    private

    def filter_refer(result, hash)
      result.select do |res|
        if hash[:refering] && hash[:referred]
          [twoch.ref_table.values].flatten.include?(res.res_index) || \
            twoch.ref_table.key?(res.res_index)
        elsif hash[:refering]
          twoch.ref_table.key?(res.res_index)
        elsif hash[:referred]
          [twoch.ref_table.values].flatten.include?(res.res_index)
        else
          true
        end
      end
    end

    def filter_from_to(result, hash)
      result = result.select do |res|
        (!hash[:from]      || hash[:from] <= res.res_index) && \
          (!hash[:to]        || hash[:to] >= res.res_index)
      end
    end

    def filter_image_youtube(result, hash)
      result = result.select do |res|
        if hash[:image] && hash[:youtube]
          next(res.image? || res.youtube?)
        end

        (!hash[:image]     || res.image?) && \
          (!hash[:youtube]   || res.youtube?)
      end
    end
  end
end
