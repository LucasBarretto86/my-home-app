module ApplicationHelper

  def svg_inline(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"

    File.read(file_path).html_safe
  end
end
