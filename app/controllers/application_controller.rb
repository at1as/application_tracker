class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_time_zone, if: :logged_in?

  include SessionsHelper

  private
  
    # Confirms user is logged-in
    def logged_in_user
      unless logged_in?
        store_location
        flash['alert-danger'] = "Please log in."
        redirect_to login_url
      end
    end

    def set_time_zone
      Time.zone = current_user.time_zone if current_user.time_zone
    end
end
