include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  #Sign in when not using Capybara as well.
  #session[:remember_token] = user.remember_token
  #The above code doesn't work. 'session' is unavailable in integeration tests.
  #If a non-Capybara login is needed, use:
  #post signin_path, email: user.email, password: user.password
end