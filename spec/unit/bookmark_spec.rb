require 'bookmark'

describe Bookmark do

  context '#initialize' do
    it 'should create a bookmark with title and url' do
      bookmark = Bookmark.new("Udemy", "https://www.udemy.com")
      expect(bookmark.title).to eq "Udemy"
    end

  end
  context '#.all' do
    it 'returns the bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      
      connection.exec(
        "INSERT INTO bookmarks (title, url) 
        VALUES ('Makers','http://www.makersacademy.com');"
        )
      connection.exec(
        "INSERT INTO bookmarks (title, url) 
        VALUES ('Google', 'http://www.google.com');"
        )
      connection.exec(
        "INSERT INTO bookmarks (title, url) 
        VALUES ('Destroy All Software', 'http://www.destroyallsoftware.com');"
        )
      bookmarks = Bookmark.all

      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
      expect(bookmarks[1].url).to eq 'http://www.google.com'
      expect(bookmarks.last.url).to eq 'http://www.destroyallsoftware.com'
    end
  end

  context '#.create' do
    it 'creates a new bookmark' do
      # Bookmark.create(title: "Udemy", url: 'https://www.udemy.com')
      expect { Bookmark.create("Udemy", 'https://www.udemy.com') }.to change { Bookmark.all.length }.by(1)
  
    end
  end
end