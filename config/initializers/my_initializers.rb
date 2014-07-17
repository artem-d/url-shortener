if Rails.env.development? || Rails.env.test?
  BASE_URL = "http://localhost:3000/"
elsif Rails.env.production?
  BASE_URL = ""
end
