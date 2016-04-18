json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password_hash, :is_doctor
  json.url user_url(user, format: :json)
end
