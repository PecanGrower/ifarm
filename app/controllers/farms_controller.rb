class FarmsController < ApplicationController

  def index
    @farms = Farm.all
  end

  def new
    @farm = Farm.new
  end

  def create
    @farm = Farm.new(params[:farm])
    if @farm.save
      flash[:success] = "New farm successfully added."
      redirect_to farms_path
    else
      render 'new'
    end
  end

end
