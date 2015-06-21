json.array!(@documents) do |document|
  json.extract! document, :id, :project_id, :category_id, :user_id, :document, :document_uploaded_at, :archived, :deleted
  json.url document_url(document, format: :json)
end
