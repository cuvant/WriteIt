class Users::RegistrationsController < Devise::RegistrationsController
  layout "devise"
  def new
    super
  end

  def create
    super
    if resource.save
      sign_in resource
    end
  end

  def update
    super
  end
  
  private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :user_name, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:email, :user_name, :password, :password_confirmation, :current_password)
  end
end 
