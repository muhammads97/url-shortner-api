module Url
  class FetchTitle
    prepend SimpleCommand
    require 'mechanize'

    def initialize(url)
      @url = url
      @agent = Mechanize.new
    end

    def call
      page = @agent.get(@url)
      page.title
    end
  end
end
