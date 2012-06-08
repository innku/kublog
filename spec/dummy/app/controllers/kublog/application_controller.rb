module Kublog
  class ApplicationController < ActionController::Base
    before_filter :require_admin

    helper_method :is_admin?
    helper_method :current_user
    helper_method :signed_in?

    def require_admin
      redirect_to root_path unless is_admin?
    end

    def current_user
      @current_user ||= User.find_by_id(session[:user_id])
    end

    def is_admin?
      current_user && current_user.admin?
    end

    def signed_in?
      !!current_user
    end
  end
end
