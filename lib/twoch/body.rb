class Twoch
  class Body < ::String
    def initialize(arg)
      super(arg.to_s)
    end
  end
end
