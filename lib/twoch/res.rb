class Twoch
  class Res < ::String
    # レス。
    def initialize(string = nil, twoch: nil, index: nil)
      super(string.to_s)
      array = split('<>').map{|e| e.gsub(/<\/*b>/){''} }
      @twoch = twoch
      @index = index
      @user, @meta, @time, body, @title = array
      @body = Body.new(body)
    end

    attr_reader *%i(user meta time body title)

    def res_index
      @index
    end

    def add_ref(n)
      twoch && twoch.add_ref(from: index, to: n)
    end
  end
end
