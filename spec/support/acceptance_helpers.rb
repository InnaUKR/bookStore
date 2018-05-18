module AcceptanceHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Enter Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Back to Store'
  end
end