require 'bookmark'

describe Bookmark do

  # context '#initialize' do
  #   it 'should create a bookmark with title and url' do
  #     bookmark = Bookmark.new("Udemy", "https://www.udemy.com")
  #     expect(bookmark.title).to eq "Udemy"
  #   end

  # end
  context '#.all' do
    it 'returns the bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      
      bookmark = Bookmark.create(url: 'http://www.makersacademy.com', title: 'Makers')
      Bookmark.create(url: 'http://www.google.com', title: 'Google')
      Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
      
      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  context '#.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'https://www.udemy.com', title: 'Udemy')
      persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Udemy'
      expect(bookmark.url).to eq 'https://www.udemy.com'
    end
  end

  context '.delete' do
    it 'delete given bookmark' do
      bookmark = Bookmark.create(title: 'Makers', url: 'http://www.makersacademy.com')

      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end

  context '.update' do
    it 'updates the bookmark with the given data' do
      bookmark = Bookmark.create(title: 'Makers', url: 'http://www.makersacademy.com')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.github.com', title: 'GitHub')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'GitHub'
      expect(updated_bookmark.url).to eq 'http://www.github.com'
    end
  end

  context '.find' do
    it 'returns a bookmark' do
      bookmark = Bookmark.create(title: 'Makers', url: 'http://www.makersacademy.com')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Makers'
      expect(result.url).to eq 'http://www.makersacademy.com'
    end
  end
end