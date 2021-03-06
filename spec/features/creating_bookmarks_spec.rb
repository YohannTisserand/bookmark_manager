feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in(:url, with: 'https://www.testbookmark.com')
    fill_in(:title, with: 'Test bookmark')
    click_button('submit')

    expect(page).to have_link('Test bookmark', href: 'https://www.testbookmark.com')
  end

  scenario 'the bookmark bust be a valid URL' do
    visit('/bookmarks/new')
    fill_in(:url, with: 'not a real bookmark')
    click_button('submit')

    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content 'You must submit a valid URL'
  end
end