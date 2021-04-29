feature 'authentication' do
  scenario 'a user can sign in' do
    User.create(email: 'test@test.com', password: 'password123')
    visit('/sessions/new')
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'password123')
    click_button('sign in')
    expect(page).to have_content('Welcome, test@test.com')
  end

  scenario 'a user sees an error if they get their email wrong' do
    User.create(email: 'test@test.com', password: 'password123')
    visit('/sessions/new')
    fill_in(:email, with: 'nottherightemail@test.com')
    fill_in(:password, with: 'password123')
    click_button('sign in')
    expect(page).not_to have_content 'Welcome, test@test.com'
    expect(page).to have_content 'Please check your email or password'
  end

  scenario 'a user sees an error if they get their password wrong' do
    User.create(email: 'test@test.com', password: 'password123')
    visit('/sessions/new')
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'wrongpassword')
    click_button('sign in')
    expect(page).not_to have_content 'Welcome, test@test.com'
    expect(page).to have_content 'Please check your email or password'
  end
end