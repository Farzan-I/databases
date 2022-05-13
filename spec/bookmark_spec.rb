require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns a list of bookmarks' do
      # con = PG.connect(dbname: 'bookmark_manager_test')

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

  describe '.update' do
    it 'updates the bookmark with the given data' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')
  
      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Snakers Academy'
      expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
    end
  end

  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      res = Bookmark.find(id: bookmark.id)

      expect(res).to be_a Bookmark
      expect(res.id).to eq bookmark.id
      expect(res.title).to eq 'Makers Academy'
      expect(res.url).to eq 'http://www.makersacademy.com'
    end
  end

end
