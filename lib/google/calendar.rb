module Google
  module Calendar

    def self.insert_event client, episode
      calendar = client.discovered_api('calendar', 'v3')

      event = episode.to_google_calendar

      client.execute(
        body_object:  event,
        api_method:   calendar.events.insert,
        parameters:  {'calendarId' => 'primary'},
        headers:     {'Content-Type' => 'application/json'}
      )
    end
  end
end
