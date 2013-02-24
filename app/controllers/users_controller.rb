class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User login successfully update."
      sign_in @user
      redirect_to company_path(@user.company)
    else
      render 'edit'
    end
  end
end
