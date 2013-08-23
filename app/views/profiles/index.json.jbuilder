json.array!(@profiles) do |profile|
  json.extract! profile, :display_name, :gravatar_email, :tagline, :reputation
  json.url profile_url(profile, format: :json)
end
