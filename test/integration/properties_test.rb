# frozen_string_literal: true

require 'test_helper'

class PropertiesTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  include Rails.application.routes.url_helpers

  setup do
    @photos = [
      fixture_file_upload('test/fixtures/files/1.jpg', 'image/jpg'),
      fixture_file_upload('test/fixtures/files/2.jpg', 'image/jpg'),
      fixture_file_upload('test/fixtures/files/3.jpg', 'image/jpg'),
      fixture_file_upload('test/fixtures/files/4.jpg', 'image/jpg')
    ]
    @property = Property.create(name: 'Lehner Glen', photos: @photos)
  end

  test 'that layout has the correct page title' do
    get properties_path

    assert_select 'title', text: /MyHomeApp/
    assert_select 'h1', text: /MyHome, where your home might be!/
  end

  test 'that header about button modal has the correct information' do
    get properties_path

    assert_select '.dialog' do
      assert_select 'summary', text: 'About'
      assert_match /#{svg_inline :cross}/, @response.body
      assert_select 'p', text: 'Welcome everyone!'
      assert_select 'p', text: 'Website developed as a case project.'
      assert_select 'small', text: '&reg 2021 - Lucas Barretto'
    end
  end

  test 'that index displays card correct property information' do
    get properties_path

    assert_select 'h3', text: 'Available Properties'

    assert_select "#property_#{@property.id}" do
      assert_select "a[href='#{property_path(@property)}']"
      assert_select 'img[src*="3.jpg"]'
      assert_select 'h3', text: 'Lehner Glen'
      assert_select 'p', text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dic...'
    end
  end

  test 'that show displays correct data for each section' do
    get property_path(@property)

    assert_select 'style' do
      assert_match /background-image: url(.*\/3.jpg)/, @response.body
    end

    assert_select '#property-info' do
      assert_select 'h2', text: 'Lehner Glen'
      assert_select '#property-description', text: /Lorem ipsum dolor sit amet, consectetur adipisicing elit/
      assert_select '#property-highlight', text: /Ad adipisci, animi architecto assumenda earum ex fuga itaque/
    end

    assert_select '#property-gallery' do
      assert_select 'h2', text: 'Gallery'
      assert_select '.slider' do
        @property.photos.blobs do |blob|
          assert_match /img[src*='#{blob.filename}']/, @response.body
        end
      end
    end
  end

  test 'that show does not display gallery section if property has no photos' do
    @property.photos.attachments.each(&:destroy)
    @property.reload

    get property_path(@property)

    assert_select '#property-gallery', count: 0
  end
end
