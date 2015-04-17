Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Settings.github_client_id, Settings.github_client_secret, scope: 'user,repo'
end
