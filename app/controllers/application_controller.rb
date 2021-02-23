# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource_or_scope)
    rails_admin_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_api_admin_session_path
  end
end
