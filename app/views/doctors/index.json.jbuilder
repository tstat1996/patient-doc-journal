json.array!(@doctors) do |doctor|
  json.extract! doctor, :id, :name, :email, :password_hash
  json.url doctor_url(doctor, format: :json)
end
