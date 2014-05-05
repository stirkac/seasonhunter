class ApplicationController < ActionController::Base


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_filter :set_config

  require 'themoviedb'

  Tmdb::Api.key(ENV["MOVIE_DB"])

  def set_config

    @configuration = Tmdb::Configuration.new
  end

  def index
    @popular = Tmdb::TV.popular
    @top_rated = Tmdb::TV.top_rated
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
