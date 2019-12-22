
# Feature: User index page
#   As a user
#   I want to see a list of users
#   So I can see who has registered
feature 'User index page', :devise do

  # Scenario: User listed on index page
  #   Given I am signed in
  #   When I visit the user index page
  #   Then I see my own name
  scenario 'user sees own name in list' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit users_path
    expect(page.status_code).to eq(200)
    expect(page).to have_content user.full_name
  end

end
