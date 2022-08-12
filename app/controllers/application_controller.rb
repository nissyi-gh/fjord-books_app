# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user?, :user_name_or_email

  protected

  def configure_permitted_parameters
    keys = %i[name postal_code address self_introduction avatar]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  private

  def after_sign_in_path_for(_resource_or_scope)
    books_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def signed_in_root_path(_resource_or_scope)
    user_path(current_user)
  end

  def current_user?(user)
    current_user == user
  end

  def user_name_or_email(user)
    user.name.presence || user.email
  end
end
