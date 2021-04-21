feature 'creating a new bookmark' do
  scenario 'allows to store a new bookmark' do
    visit('/bookmarks/new')
    fill_in('url', with: 'https://www.udemy.com')
    click_button('Submit')
    expect(page).to have_content 'https://www.udemy.com'
  end
end