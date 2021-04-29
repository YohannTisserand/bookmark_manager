require 'bookmark'
require 'database_helpers'

describe Bookmark do
  context '.all' do
    it 'returns a list of bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')      

      bookmark = Bookmark.create(url: 'https://www.google.com', title: 'Google')
      Bookmark.create(url: 'https://www.codewars.com', title: 'Codewars')
      Bookmark.create(url: 'https://www.udemy.com', title: 'Udemy')

      bookmarks = Bookmark.all
    
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Google'
      expect(bookmarks.first.url).to eq 'https://www.google.com'
    end
  end

  context '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'https://www.testbookmark.com', title: 'Test bookmark')
      persisted_data = persisted_data(table: :bookmarks, id: bookmark.id)
      
      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Test bookmark'
      expect(bookmark.url).to eq 'https://www.testbookmark.com'
    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(Bookmark.all).to be_empty
    end
  end

  context '.delete' do
    it 'delete a bookmark' do
      bookmark = Bookmark.create(title: 'Google', url: 'https://www.google.com')
      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end

  context '.update' do
    it 'updates the bookmark' do
      bookmark = Bookmark.create(url: 'https://www.testbookmark.com', title: 'Test bookmark')
      update_bookmark = Bookmark.update(id: bookmark.id, url: 'https://www.test.com', title: 'Test')

      expect(update_bookmark).to be_a Bookmark
      expect(update_bookmark.id).to eq bookmark.id
      expect(update_bookmark.title).to eq 'Test'
      expect(update_bookmark.url).to eq 'https://www.test.com'
    end
  end

  context '.find' do
    it 'show the bookmarks' do
      bookmark = Bookmark.create(url: 'https://www.testbookmark.com', title: 'Test')
      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Test'
      expect(result.url).to eq 'https://www.testbookmark.com'
    end
  end

  context '#comment' do
    it 'returns comments' do
      bookmark = Bookmark.create(title: 'Google', url: 'https://www.google.com')
      DBConnection.query("INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Google', #{bookmark.id})")

      comment = bookmark.comments.first

      expect(comment['text']).to eq 'Google'
    end
  end
end
