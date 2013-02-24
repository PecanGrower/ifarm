class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]

  def edit
  end

  def update
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

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end