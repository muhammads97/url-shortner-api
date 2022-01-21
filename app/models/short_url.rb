class ShortUrl < ApplicationRecord
  require 'uri'

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  def short_code
    code = ""
    base = CHARACTERS.length
    tmp = id-1
    
    loop do
      code = CHARACTERS[tmp%base] + code
      tmp = tmp / base
      break if tmp <= 0
    end
    code
  end

  def update_title!
  end

  private

  def validate_full_url
    if full_url.length == 0
      errors.add(:full_url, "can't be blank")
    else
      begin
        url = URI.parse(full_url)
        valid = url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
      rescue 
        valid = false
      end
      errors.add(:full_url, "is not a valid url") if !valid
    end

  end
  

end
