require 'pg'

class Bookmark
  attr_reader :title, :url

  def initialize(title, url)
    @title = title
    @url = url
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager') 
    end
    
    result = connection.exec("SELECT * FROM bookmarks;")
    result.map do |bookmark| 
      Bookmark.new(bookmark['title'], bookmark["url"]) 
    end
  end

  def self.create(title, url)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager') 
    end

    connection.exec(
      "INSERT INTO bookmarks(title, url) VALUES('#{title}', '#{url}')"
      )
  end
end
