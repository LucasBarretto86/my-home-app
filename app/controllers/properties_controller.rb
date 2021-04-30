class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit]

  def index
    @properties = Property.all
  end

  def show
    @property = Property.find(params[:id])
  end
end
