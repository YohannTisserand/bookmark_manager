feature 'A user can update a bookmark' do
  scenario 'allow a user to update a bookmark' do
    bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers')
    visit('/bookmarks')
    expect(page).to have_link('Makers', href: 'http://www.makersacademy.com')

    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: 'http://www.github.com')
    fill_in('title', with: "GitHub")
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers', href: 'http://www.makersacademy.com')
    expect(page).to have_link('GitHub', href: 'http://www.github.com')
  end
end