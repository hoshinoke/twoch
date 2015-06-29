class Twoch
  class DatUri < ::String
    # datのURLに変換する。
    def convert(arg)
      if %r(http://(\S+)\.2ch\.(\S+)/test/read.cgi/(\S+)/(\S+)/(\S*)) =~ arg
        "http://#{$1}.2ch.#{$2}/#{$3}/dat/#{$4}.dat"
      else
        arg
      end
    end
  end
end
