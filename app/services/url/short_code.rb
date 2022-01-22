module Url
  module ShortCode
    CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze
    BASE = CHARACTERS.length.freeze
  end
end