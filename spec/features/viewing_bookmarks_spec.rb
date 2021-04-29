feature 'Viewving bookmarks' do
  scenario 'a user can see bookmarks' do
    Bookmark.create(url: 'https://www.google.com', title: 'Google')
    Bookmark.create(url: 'https://www.codewars.com', title: 'Codewars')
    Bookmark.create(url: 'https://www.udemy.com', title: 'Udemy')

    visit('/bookmarks')

    expect(page).to have_link('Google', href: "https://www.google.com")
    expect(page).to have_link('Codewars', href: "https://www.codewars.com")
    expect(page).to have_link('Udemy', href: "https://www.udemy.com")
  end
end
