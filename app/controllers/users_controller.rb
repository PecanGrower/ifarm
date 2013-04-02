class UsersController < ApplicationController
  before_filter :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.company_id = Company.current_id
    if @user.save
      flash[:success] = "New user succesfully created"
      redirect_to root_path
    else
      render 'new'
    end
  end

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
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end