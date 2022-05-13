require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns a list of bookmarks' do
      con = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: 'Makers Academy')
      Bookmark.create(url: "http://www.bbc.co.uk", title: 'BBC')
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: 'Destroy Software')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'

    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Example title')
      database_bookmark = database_bookmarks(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq database_bookmark.first['id']
      expect(bookmark.url).to eq 'http://www.example.org'
      expect(bookmark.title).to eq 'Example title'
    end
  end 

  describe '.delete' do
    it 'deletes a specific bookmark from bookmarks' do
      bookmark = Bookmark.create(url: 'http://www.example.org', title: 'Example title')
      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end
end
