require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  setup do
    @property = properties(:lorem)
    @path = Rails.root.join("tmp/images")
  end

  test 'That property is valid' do
    assert Property.create(name: 'lorem')
  end

  test 'That Property is invalid' do
    assert_raises ActiveRecord::RecordInvalid do
      Property.create!
    end
  end

  test 'That many photos cant be attached' do

  end

  test 'That cover is the third photo attached if more than 2 photos are attached' do
    Dir.children(@path).sort.each do |file|
      @property.photos.attach(io: File.open([@path, file].join('/')), filename: file)
    end

    assert_equal @property.photos.blobs.third, @property.cover.blob
  end

  test 'That cover is the first photo attached if less than 3 are attached' do
    Dir.children(@path).slice(0, 2).sort.each do |file|
      @property.photos.attach(io: File.open([@path, file].join('/')), filename: file)
    end

    assert_equal @property.photos.blobs.first, @property.cover.blob
  end
end
