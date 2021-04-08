# frozen_string_literal: true

module Admins
  class BaseController < ActionController::Base
    before_action :authenticate_admin!
    before_action :configure_permitted_parameters, if: :devise_controller?

    layout "application_admin"
  end
end
