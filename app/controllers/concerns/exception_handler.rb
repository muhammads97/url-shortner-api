module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  end

  private 

  def render_record_invalid(exception)
    msgs = exception.record.errors.messages
    errors = []
    msgs.keys.each do |k|
      key_split = k.to_s.split('_')
      key_split[0][0] = k[0].upcase
      key = key_split.join(" ")
      msgs[k].each do |m|
        errors.push("#{key} #{m}")
      end
    end
    render json: {errors: errors}, status: :unprocessable_entity
  end

  def render_record_not_found(exception)
    render json: {errors: exception}, status: :not_found
  end
end