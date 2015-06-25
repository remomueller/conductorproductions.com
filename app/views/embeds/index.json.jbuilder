json.array!(@embeds) do |embed|
  json.extract! embed, :id, :project_id, :category_id, :user_id, :embed_url, :archived, :deleted
  json.url embed_url(embed, format: :json)
end
