Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
  {
    :name => "google",
    :scope => [ "userinfo.email",
                "userinfo.profile",
                "https://www.googleapis.com/auth/calendar"
              ].join(", "),
    :image_aspect_ratio => "square",
    :image_size => 50
  }
end
