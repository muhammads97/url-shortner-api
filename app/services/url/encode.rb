module Url
  class Encode
    prepend SimpleCommand

    def initialize(id)
      @id = id
    end

    def call
      return nil if !@id
      code = ""
      base = Url::ShortCode::BASE
      tmp = @id-1
    
      loop do
        code = Url::ShortCode::CHARACTERS[tmp%base] + code
        tmp = tmp / base
        break if tmp <= 0
      end
      code
    end

  end
end