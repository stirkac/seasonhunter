require 'google/calendar'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
  { :scope => [ "userinfo.email",
                "userinfo.profile",
                "https://www.googleapis.com/auth/calendar"
              ].join(", ")
  }
end
