module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation , state = nil)
      visit new_user_registration_path
      fill_in 'Full name', with: "some name"
      fill_in 'City', with: "some city"
      fill_in( 'user[state]', with: state) if state
      fill_in 'user[country]', with: "some place"
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: confirmation
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end

    def signed_user factory = :user
      user = FactoryBot.create(factory)
      user.confirm
      login_as(user, :scope => :user)
      user
    end
  end
end
