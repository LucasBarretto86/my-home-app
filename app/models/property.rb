# frozen_string_literal: true

class Property < ApplicationRecord
  has_many_attached :photos

  validates :name, presence: true

  def cover
    return nil unless photos.attached?

    photo = photos.third || photos.first

    photo.variant(resize: '256x256').processed
  end
end
