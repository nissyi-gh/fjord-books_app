# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  def avatar_thumbnail
    avatar.variant(gravity: :center, resize:"48x48^", crop:"48x48+0+0")
  end
end
