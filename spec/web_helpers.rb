require 'pg'

def empty_bookmarks_test
  
  con = PG.connect :dbname => 'bookmark_manager_test'

  con.exec "TRUNCATE bookmarks"

end
