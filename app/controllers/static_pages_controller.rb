class StaticPagesController < ApplicationController
  
  skip_before_filter :signed_in_user

  def home
    @company = current_user.company if signed_in?
  end

  def help
  end

  def about    
  end

  def contact    
  end
end