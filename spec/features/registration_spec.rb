feature 'registration' do
  scenario 'a user can sign up' do
    visit '/users/new'
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'password123')
    click_button('submit')

    expect(page).to have_content 'Welcome, test@test.com'
  end
end