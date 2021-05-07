class PropertiesController < ApplicationController
  def index
    @properties = Property.with_attached_photos
  end

  def show
    @property = Property.find(params[:id])
  end
end
