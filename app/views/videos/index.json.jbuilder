json.array!(@videos) do |video|
  json.extract! video, :id, :user_id, :page, :photo, :vimeo_number, :archived, :deleted
  json.url video_url(video, format: :json)
end
