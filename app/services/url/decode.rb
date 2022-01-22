module Url
  class Decode
    prepend SimpleCommand

    def initialize(code)
      @code = code
    end

    def call
      chars = []
      
      @code.chars.reverse.each do |c|
        chars.push get_char_index(c)
      end

      m = 1
      url_id = 0
      chars.each do |c|
        url_id = url_id + c * m
        m = m * Url::ShortCode::BASE
      end

      url_id + 1
    end

    private

    def get_char_index(c)
      return c.bytes[0] - '0'.bytes[0] if c >= '0' && c <= '9'
      return c.bytes[0] - 'a'.bytes[0] + 10 if c >= 'a' && c <= 'z'
      return c.bytes[0] - 'A'.bytes[0] + 36 if c >= 'A' && c <= 'Z'
    end
  end
end