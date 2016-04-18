json.array!(@journals) do |journal|
  json.extract! journal, :id, :name, :body
  json.url journal_url(journal, format: :json)
end
