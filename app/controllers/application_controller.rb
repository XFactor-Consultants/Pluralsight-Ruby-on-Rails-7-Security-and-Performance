# frozen_string_literal: true

class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource_or_scope)
    # Rotate session token
    renew_session_id

    # Redirect to the desired path after sign-in
    stored_location_for(resource_or_scope) || super
  end

  private

  def renew_session_id
    # Change session token
    reset_session
    session[:_csrf_token] = form_authenticity_token
  end
end
