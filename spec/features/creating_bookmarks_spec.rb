feature 'creating a new bookmark' do
  scenario 'allows to store a new bookmark' do
    visit('/bookmarks/new')
    fill_in('url', with: 'https://www.udemy.com')
    fill_in('title', with: 'Udemy')
    click_button('Submit')
    expect(page).to have_link('Udemy')
  end
end
