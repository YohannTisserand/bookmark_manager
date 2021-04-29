feature 'Adding and view comments' do
  feature 'a user can add and view a comment' do
    scenario 'a comment is added to bookmark' do
      bookmark = Bookmark.create(url: 'https://www.google.com', title: 'Google')
      
      visit '/bookmarks'
      first('.bookmark').click_button 'Add Comment'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"

      fill_in(:comment, with: 'This is a test comment on this bookmark')
      click_button('submit')

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'This is a test comment on this bookmark'
    end
  end
end