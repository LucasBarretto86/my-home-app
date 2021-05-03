# frozen_string_literal: true

require 'application_system_test_case'
require 'faker'

class PropertiesTest < ApplicationSystemTestCase
  include ActionDispatch::TestProcess::FixtureFile

  setup do
    @properties = 5.times.map do
      Property.create name: Faker::Address.street_name,
                      photos: [
                        fixture_file_upload('test/fixtures/files/1.jpg', 'image/jpg'),
                        fixture_file_upload('test/fixtures/files/2.jpg', 'image/jpg'),
                        fixture_file_upload('test/fixtures/files/3.jpg', 'image/jpg')
                      ]
    end

    @property = @properties.first
  end

  test 'that on header modal display information and works properly' do
    visit properties_url

    within '#dialog-about' do
      find('.dialog__trigger').click

      within '.dialog__container' do
        assert_selector '.dialog__head', wait: 5
        assert_text 'About'

        assert_selector '.dialog__body', wait: 5
        assert_text 'Welcome everyone!'
        assert_text 'Website developed as a case project.'
        assert_text '® 2021 - Lucas Barretto'

        find('.dialog__close').click
      end
    end

    assert_no_selector '.dialog__body'
  end

  test 'that on index properties list displays the correct amount of properties' do
    visit properties_url

    assert_selector '#properties-index'

    assert_selector '.property', count: @properties.length
  end

  test 'that on index by clicking on more details button go to show property page' do
    visit properties_url

    assert_selector '#properties-index'

    within "#property_#{@property.id}" do
      click_link 'More details', wait: 5
    end

    assert_selector "#property_#{@property.id}-show"
  end

  test 'that on show by clicking on the header logo it redirects to the property index page' do
    visit property_url(@property)

    assert_selector "#property_#{@property.id}-show"

    within 'header' do
      click_link 'MyHome, where your home might be!', wait: 5
    end

    assert_selector '#properties-index'
  end

  test 'that on show slider works properly' do
    visit property_url(@property)

    assert_selector "#property_#{@property.id}-show"
    assert_selector '.slider'

    assert_selector 'div[data-current-index="1"]'
    assert_selector 'div[data-total-indexes="3"]'
    assert_no_selector '.slider__stepper--prev'
    assert_selector '.slider__stepper--next'

    2.times { find('.slider__stepper--next').click }

    assert_selector 'div[data-current-index="3"]'
    assert_selector 'div[data-total-indexes="3"]'
    assert_no_selector '.slider__stepper--next'
    assert_selector '.slider__stepper--prev'
  end
end
