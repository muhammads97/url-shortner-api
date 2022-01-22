class ShortUrl < ApplicationRecord
  require 'uri'

  validate :validate_full_url

  def short_code
    Url::Encode.call(id).result
  end

  def update_title!
    update_attribute :title, Url::FetchTitle.call(full_url).result
  end

  scope :find_by_short_code, -> (code) {
    find(Url::Decode.call(code).result)
  }

  private

  def validate_full_url
    if !full_url || full_url.length == 0
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
