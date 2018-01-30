class ApplicationController < ActionController::Base
  # TODO wip comments in microposts#index
  # TODO add load_and_authorize_resources in all controllers
  # TODO add a different sound for each notification type

  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  skip_before_action :verify_authenticity_token, if: :json_request?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end


  def json_request?
    request.format.json?
  end

  def current_user
    User.find_by_authentication_token(params[:auth_token]) || ( warden.authenticate(scope: :user) rescue nil)
  end

  def remember_token
    data = User.serialize_into_cookie @user
    "#{data.first.first}-#{data.last}"
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  private

  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)
    if user
      sign_in user, store: false
    end
  end

  def invalid_credentials
    render json: {}, status: 401
  end

  def configure_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :image, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :image, :password_confirmatio])
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

end
