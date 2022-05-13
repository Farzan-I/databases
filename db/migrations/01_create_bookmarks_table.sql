# in migrations/01_create_bookmarks_table.sql
CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60));

INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com/');
INSERT INTO bookmarks (url) VALUES ('http://www.twitter.com/');
INSERT INTO bookmarks (url) VALUES ('http://www.google.com/');
UPDATE bookmarks SET url = 'http://www.destroyallsoftware.com/' WHERE url = 'http://www.twitter.com/';