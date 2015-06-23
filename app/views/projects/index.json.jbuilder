json.array!(@projects) do |project|
  json.extract! project, :id, :name, :slug, :agency_logo, :user_id, :deleted
  json.url project_url(project, format: :json)
end
