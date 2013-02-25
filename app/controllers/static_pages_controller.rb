class StaticPagesController < ApplicationController
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
