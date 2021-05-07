# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test 'That svg_inline method render svg correctly' do
    assert_match svg_inline(:home), '<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 372 418"><path d="M174.6 385.2L135.5 339.1H47.5V137.3L185.9 37.8 324.2 137.3V339.1H224.6" style="fill:none;stroke-linejoin:round;stroke-width:32;stroke:#007bff"/></svg>'
  end

  test 'That svg_inline method raises exception when file is not found' do
    assert_raises(Errno::ENOENT) { svg_inline(:nothing) }
  end
end