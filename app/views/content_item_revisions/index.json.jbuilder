json.array!(@content_item_revisions) do |content_item_revision|
  json.extract! content_item_revision, :id, :content, :content_item_revision_id, :created_by, :last_modified_by, :change_set_id
  json.url content_item_revision_url(content_item_revision, format: :json)
end
