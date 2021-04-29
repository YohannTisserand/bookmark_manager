feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in(:url, with: 'https://www.testbookmark.com')
    fill_in(:title, with: 'Test bookmark')
    click_button('submit')

    expect(page).to have_link('Test bookmark', href: 'https://www.testbookmark.com')
  end
end