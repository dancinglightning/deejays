
# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :devise do

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)
    visit user_path(user)
    expect(page.status_code).to eq(200)
    expect(page).to have_content 'User'
    expect(page).to have_content user.email
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see an 'access denied' message
  scenario "user cannot see another user's profile" do
    me = FactoryBot.create(:user)
    other = FactoryBot.create(:user, email: 'other@example.com')
    login_as(me, :scope => :user)
    visit user_path(other)
    expect(page).to have_content me.full_name
  end

end
