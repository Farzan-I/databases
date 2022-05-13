require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.all

    if ENV['RACK_ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end    
    
    rs = con.exec "SELECT * FROM bookmarks"
    
    rs.map do |bookmark|
      Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
    end
    
  end
  
  def self.create(url:, title:)
    if ENV['RACK_ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end     
    
    res = con.exec_params("INSERT INTO bookmarks (url, title) VALUES($1, $2) RETURNING id, title, url;", [url, title])

    Bookmark.new(id: res[0]['id'], title: res[0]['title'], url: res[0]['url'])
  end

  def self.delete(id:)
    if ENV['RACK_ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end     

    con.exec_params("DELETE FROM bookmarks WHERE id = $1", [id])
  end
end
