class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  expose(:tmdb_base_url) { Tmdb::Configuration.new.base_url }
  expose(:popular) { Tmdb::TV.popular }
  expose(:top_rated) { Tmdb::TV.top_rated }

  def index
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
