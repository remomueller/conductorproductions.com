json.array!(@locations) do |location|
  json.extract! location, :id, :project_id, :category_id, :user_id, :name, :address, :archived, :deleted
  json.url location_url(location, format: :json)
end
