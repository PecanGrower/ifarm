class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :signed_in_user
  around_filter :scope_current_company

  private

    # -------- Company Data Segration Methods -------

    def scope_current_company
      Company.current_id = current_company.id if signed_in?
      yield
    ensure
      Company.current_id = nil
    end

    def current_company
      current_user.company
    end

    # -------- User Authentication Methods ----------

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: 'Please sign in.' 
      end
    end

    def sign_in(user)
      session[:remember_token] = user.remember_token
      self.current_user = user
    end

    def signed_in?
      !current_user.nil?
    end
    helper_method :signed_in?

    def sign_out
      self.current_user = nil
      session.delete(:remember_token)
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user
      @current_user ||= User.find_by_remember_token(session[:remember_token])
    end
    helper_method :current_user

    def current_user?(user)
      user == current_user
    end

    # -------- Friendly Forwarding Methods ----------

    def store_location
      session[:return_to] = request.url
    end

    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end


end