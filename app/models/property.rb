# frozen_string_literal: true

class Property < ApplicationRecord
  has_many_attached :photos

  validates :name, presence: true

  def cover
    return nil unless photos.attached?

    photos.third || photos.first
  end
end
