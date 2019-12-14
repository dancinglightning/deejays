class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.credentials.admin_email) do |user|
        user.password = Rails.application.credentials.admin_password
        user.password_confirmation = Rails.application.credentials.admin_password
        user.confirm!
      end
  end
end
