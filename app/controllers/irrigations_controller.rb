class IrrigationsController < ApplicationController

  def index
    @irrigations = Irrigation.order("time DESC")
    @irrigation = Irrigation.new
  end

  def create
    field = Field.find(params[:irrigation][:field_id])
    @irrigation = field.irrigations.build(params[:irrigation].except(:field_id))
    if @irrigation.save
      redirect_to irrigations_path
    else
      @irrigations = Irrigation.order("time DESC")
      render :index
    end
  end

  def edit
    @irrigations = Irrigation.order("time DESC")
    @irrigation = Irrigation.find(params[:id])
    render :index
  end
end
