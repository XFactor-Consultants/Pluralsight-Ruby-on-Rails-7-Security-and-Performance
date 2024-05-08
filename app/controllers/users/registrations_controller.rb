class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  def update_resource(resource, params)
    if params[:password]&.present?
      # Force sign out the user to prevent session use after password change
      sign_out_all_scopes
      flash[:notice] = 'You have been logged out due to password change'
    end
    resource.update_with_password(params)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[password password_confirmation current_password])
  end
end
