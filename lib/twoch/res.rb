class Twoch
  class Res < ::String
    # レス。
    def initialize(*args)
      super
      array = split('<>').map{|e| e.gsub(/<\/*b>/){''} }
      @user, @meta, @time, body, @title = array
      @body = Body.new(body)
    end

    attr_reader *%i(user meta time body title)
  end
end
