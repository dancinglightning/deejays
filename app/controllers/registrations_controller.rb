class RegistrationsController < Devise::RegistrationsController
  invisible_captcha only: [:create, :update], honeypot: :title

  private

  def base_set
    [:full_name, :city , :country , :state, :email, :password, :password_confirmation]
  end
  def sign_up_params
    params.require(:user).permit(base_set)
  end

  def account_update_params
    params.require(:user).permit(base_set +  [:current_password])
  end
end
