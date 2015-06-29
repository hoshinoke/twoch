class Twoch
  class Line < ::String
    def initialize(*args)
      super
      array = split('<>').map{|e| e.gsub(/<\/*b>/){''} }
      @user, @meta, @time, @body, @title = array
    end

    attr_reader *%i(user meta time body title)
  end
end
