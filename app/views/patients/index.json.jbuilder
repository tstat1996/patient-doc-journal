json.array!(@patients) do |patient|
  json.extract! patient, :id, :name, :email, :password_hash
  json.url patient_url(patient, format: :json)
end
