class IrrigationsController < ApplicationController

  def index
    @irrigations = Irrigation.order("time DESC")
  end
end
