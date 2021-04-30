require 'database_helpers'

require 'comment'
require 'bookmark'

describe Comment do
  context '.create' do
    it 'creates a new comment' do
      bookmark = Bookmark.create(url: 'https://www.google.com', title: 'Google')
      comment = Comment.create(text: 'this is a comment', bookmark_id: bookmark.id)

      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(comment).to be_a Comment
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'this is a comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
  context '.where' do
    it 'gets the relevant comments from the database' do
      bookmark = Bookmark.create(url: 'https://www.google.com', title: 'Google')
      Comment.create(text: 'This is a test', bookmark_id: bookmark.id)

      comments = Comment.where(bookmark_id: bookmark.id)
      comment = comments.first
      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(comments.length).to eq 1
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'This is a test'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
end
