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
    Url::Validate.call(full_url).result.each do |error|
      errors.add(:full_url, error)
    end
  end
end
