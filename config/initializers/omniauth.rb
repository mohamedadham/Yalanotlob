Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "2854010401350485", "df5c3415db149010e2a652381acb425e"
end