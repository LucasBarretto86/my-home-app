# frozen_string_literal: true

require 'test_helper'
require 'faker'
class PropertyControllerTest < ActionDispatch::IntegrationTest

  setup do
    @property = Property.create name: Faker::Address.street_name
  end

  test 'that the action index redirects to the property main list' do
    get properties_path
    assert_response 200
    assert_select '#properties-index'
  end

  test 'that the action show redirects to the property details' do
    get property_path @property
    assert_response 200
    assert_select "#property_#{@property.id}-show"
  end
end
