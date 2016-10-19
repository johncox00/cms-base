json.array!(@change_sets) do |change_set|
  json.extract! change_set, :id, :created_by, :active_at, :inactive_at
  json.url change_set_url(change_set, format: :json)
end
