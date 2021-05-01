class ApplicationController < ActionController::Base
  before_action :set_variant

  private

  def set_variant
    request.variant = :desktop unless request.user_agent =~ /Mobile|webOS/
  end
end