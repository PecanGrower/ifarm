class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]

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

  private
    def signed_in_user
      redirect_to signin_url, notice: 'Please sign in.' unless signed_in?
    end
end
