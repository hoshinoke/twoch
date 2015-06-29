class Twoch
  class Line < ::String
    def initialize(*args)
      super
      @user, @meta, @time, @body, @title = split('<>')
    end

    attr_reader *%i(user meta time body title)
  end
end
