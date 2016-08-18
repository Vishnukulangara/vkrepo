OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "66767194447-3saerr6c609m5ua75aiviutpo8imf7hb.apps.googleusercontent.com", "Gm6tOp7lHhZbVgKOYb4DIWBj", {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end