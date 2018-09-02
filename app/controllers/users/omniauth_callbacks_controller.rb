class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :require_admin_or_staff_user!

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def surveymonkey
    current_user.surveymonkey_token = request.env["omniauth.auth"].credentials.token
    current_user.surveymonkey_uid =  request.env["omniauth.auth"].uid
    current_user.save
    
    redirect_to edit_user_registration_path
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
