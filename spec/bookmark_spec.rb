require 'bookmark'

describe Bookmark do
  context '#.all' do
    it 'returns the bookmarks' do
      bookmarks = Bookmark.all

      expect(bookmarks).to include 'http://www.makersacademy.com'
      expect(bookmarks).to include 'http://www.google.com'
      expect(bookmarks).to include 'http://www.destroyallsoftware.com'
    end
  end
end
