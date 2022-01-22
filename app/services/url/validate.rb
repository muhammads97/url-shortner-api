module Url
  class Validate
    prepend SimpleCommand

    def initialize(url)
      @url = url
    end

    def call
      errors = []
      errors.push "can't be blank" if !@url || @url.length == 0
      begin
        parsed = URI.parse(@url)
        valid = parsed.kind_of?(URI::HTTP) || parsed.kind_of?(URI::HTTPS)
      rescue 
        valid = false
      end
      errors.push "is not a valid url" if !valid
      errors
    end
  end
end