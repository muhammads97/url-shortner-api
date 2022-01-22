class ShortUrl < ApplicationRecord
  require 'uri'

  validate :validate_full_url

  def short_code
    Url::Encode.call(id).result
  end

  def update_title!
    update_attribute :title, Url::FetchTitle.call(full_url).result
  end

  def increment_click_count!
    update_attribute :click_count, click_count+1
  end

  def public_attributes
    json = Jbuilder.new do |url|
      url.id id
      url.full_url full_url
      url.title title
      url.click_count click_count
      url.short_code short_code
    end
    json.attributes!
  end

  scope :find_by_short_code, -> (code) {
    find(Url::Decode.call(code).result)
  }

  scope :top, -> (count) {
    order(click_count: :desc).limit(count)
  }

  private

  def validate_full_url
    Url::Validate.call(full_url).result.each do |error|
      errors.add(:full_url, error)
    end
  end
end
