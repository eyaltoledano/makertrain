module SessionsHelper

  def login_or_signup
    current_uri = request.env['PATH_INFO']
    if current_uri.include?("login")
      "Login"
    else
      "Signup"
    end
  end
end
