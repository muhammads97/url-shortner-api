class ShortUrlsController < ApplicationController
  include ExceptionHandler
  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    @urls = ShortUrl.top(100)
    respond_to do |format|
      format.json 
    end
  end

  def create
    @url = ShortUrl.create!(short_url_params)
    UpdateTitleJob.perform_later(@url.id)
    respond_to do |format|
      format.json 
    end
  end

  def show
    code = params[:id]
    @url = ShortUrl.find_by_short_code(code)
    @url.increment_click_count!
    redirect_to @url.full_url
  end

  private

  def short_url_params
    params.permit(:full_url)
  end

end
