# frozen_string_literal: true

require 'test_helper'

class PropertiesTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  include Rails.application.routes.url_helpers

  test 'that layout has the correct page title' do
    get properties_path

    assert_select 'title', text: /MyHomeApp/
    assert_select 'h1', text: /MyHome, where your home might be!/
  end

  test 'that header about button has the correct information' do
    get properties_path
    assert_select '.dialog' do
      assert_select 'summary', text: 'About'
      assert_match /#{svg_inline :cross}/, @response.body
      assert_select 'p', text: 'Welcome everyone!'
      assert_select 'p', text: 'Website developed as a case project.'
      assert_select 'small', text: '&reg 2021 - Lucas Barretto'
    end
  end

  test 'that on index cards have the correct property information' do
    get properties_path

    assert_select 'h1', text: /MyHome, where your home might be!/

    assert_select '#property_1' do
      assert_select "a[href='#{property_path(properties(:property_1))}']"
      assert_select 'img[src*="1.jpg"]'
      assert_select 'h3', text: 'Lehner Glen'
      assert_select 'p', text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dic...'
    end
  end

  test 'that on show a specific property data is displayed correctly' do
    get property_path(properties(:property_3))

    assert_select 'h1', text: /MyHome, where your home might be!/

    assert_select 'style' do
      assert_match /#{properties(:property_3).cover.blob.filename}/, @response.body
    end

    assert_select '.container' do
      assert_select 'h2', text: 'Martin Cliffs'

      assert_select ".slider" do
        properties(:property_3).photos.blobs do |blob|
          assert_match /img[src*='#{blob.filename}']/, @response.body
        end
      end
    end
  end
end
