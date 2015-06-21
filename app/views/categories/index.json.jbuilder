json.array!(@categories) do |category|
  json.extract! category, :id, :name, :slug, :project_id, :user_id, :deleted
  json.url category_url(category, format: :json)
end
