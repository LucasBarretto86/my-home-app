module ApplicationHelper

  def svg_inline(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"

    return File.read(file_path).html_safe if File.exists?(file_path)
  end
end
