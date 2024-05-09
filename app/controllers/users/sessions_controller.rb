# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  prepend_before_action :check_email_presence, only: [:create]

  def create
    self.resource = warden.authenticate(auth_options)
    if resource
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      flash[:alert] = 'Invalid login credentials'
      redirect_to new_user_session_path
    end
  end

  private

  def check_email_presence
    unless User.exists?(email: params[:user][:email])
      flash[:alert] = 'Invalid login credentials'
      redirect_to new_user_session_path
    end
  end
end
