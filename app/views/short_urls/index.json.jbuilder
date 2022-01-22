json.urls do
  json.array! @urls, partial: 'url', as: :url
end