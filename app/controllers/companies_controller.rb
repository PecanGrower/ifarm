class CompaniesController < ApplicationController

  def new
    @company = Company.new
    @company.users.build
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
    #   flash[:success] = "Welcome to iFarmPro!"
      redirect_to company_path(@company)
    else
      render 'new'
    end
  end

  def show
    @company = Company.find(params[:id])
  end
end
