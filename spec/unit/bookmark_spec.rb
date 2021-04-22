require 'bookmark'

describe Bookmark do
  context '#.all' do
    it 'returns the bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.google.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES ('http://www.destroyallsoftware.com');")
      bookmarks = Bookmark.all

      expect(bookmarks).to include 'http://www.makersacademy.com'
      expect(bookmarks).to include 'http://www.google.com'
      expect(bookmarks).to include 'http://www.destroyallsoftware.com'
    end
  end

  context '#.create' do
    it 'creates a new bookmark' do
      Bookmark.create(url: 'https://www.udemy.com')
      expect(Bookmark.all).to include 'https://www.udemy.com'
    end
  end
end