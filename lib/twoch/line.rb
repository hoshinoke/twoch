class Twoch
  class Line < ::String
    def user
      split('<>')[0]
    end

    def meta
      split('<>')[1]
    end

    def time
      split('<>')[2]
    end

    def body
      split('<>')[3]
    end

    def title
      split('<>')[4]
    end
  end
end
