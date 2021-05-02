# frozen_string_literal: true

require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess::FixtureFile

  setup do
    @photos = [
      fixture_file_upload('test/fixtures/files/1.jpg', 'image/jpg'),
      fixture_file_upload('test/fixtures/files/2.jpg', 'image/jpg'),
      fixture_file_upload('test/fixtures/files/3.jpg', 'image/jpg'),
      fixture_file_upload('test/fixtures/files/4.jpg', 'image/jpg')
    ]
    @property = Property.create(name: 'Lehner Glen', photos: @photos)
  end

  test 'That property is valid' do
    assert Property.create(name: 'lorem')
  end

  test 'That Property is invalid' do
    assert_raises ActiveRecord::RecordInvalid do
      Property.create!
    end
  end

  test 'That cover is the third photo attached if more than 2 photos are attached' do
    assert_equal @property.photos.blobs.third, @property.cover.blob
  end

  test 'That cover is the first photo attached if less than 3 are attached' do
    @property.photos.fourth.purge
    @property.photos.third.purge

    @property.reload
    assert_equal @property.photos.blobs.first, @property.cover.blob
  end
end
