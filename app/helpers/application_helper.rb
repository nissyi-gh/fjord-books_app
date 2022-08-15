# frozen_string_literal: true

module ApplicationHelper
  def current_user?(user)
    current_user == user
  end

  def user_name_or_email(user)
    user.name.presence || user.email
  end
end
