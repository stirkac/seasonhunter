class Episode
  attr_accessor :show_id
  attr_accessor :season_n
  attr_accessor :episode_n

  def initialize show_id, season_n, episode_n
    @show_id = show_id
    @season_n = season_n
    @episode_n = episode_n
  end

  def show
    @show ||= Tmdb::TV.detail show_id
  end

  def episode
    @episode ||= Tmdb::Episode.detail show_id, season_n, episode_n
  end

  def calendar_summary
    episode.name
  end

  def calendar_description
    episode.description
  end

  def to_google_calendar
    event = {
      "summary" => "#{show.name} - (#{season_n}x#{episode_n}) #{episode["name"]}",
      "description" => [episode["overview"], show.overview].select(&:present?)
    }

    if episode["air_date"].present?
      e_start = episode["air_date"]
      e_end = e_start

      event.reverse_merge!(
        "start"=>{  "date" => e_start },
        "end"  =>{  "date" => e_end   }
      )
    end

    event
  end

end
