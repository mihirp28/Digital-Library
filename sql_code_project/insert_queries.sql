-- Insert queries for Author table
-- These query is written by Isha
INSERT INTO Authors (AuthorName, LanguageCode, AuthorRating)
SELECT DISTINCT Author, language_code, Author_Rating
FROM sample_data;

INSERT INTO Authors (AuthorName, LanguageCode, AuthorRating) VALUES
('Isabella Knightley', 'en', 'Expert'),
('Rafael Moreno', 'es', 'Intermediate'),
('Yuki Nagato', 'ja', 'Intermediate'),
('Amira Sayed', 'ar', 'Novice'),
('Ethan Hawke', 'en', 'Expert'),
('Lara Croft', 'en', 'Intermediate'),
('Nikolai Volkov', 'ru', 'Novice'),
('Samantha Bee', 'en', 'Expert'),
('Carlos Ruiz', 'es', 'Intermediate'),
('Anika Chopra', 'hi', 'Novice');

select * from Authors order by AuthorID;

-- These query is written by Neha 
-- Insert queries for Genre table
INSERT INTO Genres (GenreName)
SELECT DISTINCT genre
FROM sample_data;

INSERT INTO Genres (GenreName) VALUES ('Cyber Mystery');
INSERT INTO Genres (GenreName) VALUES ('Quantum Fiction');
INSERT INTO Genres (GenreName) VALUES ('Mythopoeia');
INSERT INTO Genres (GenreName) VALUES ('Solarpunk');
INSERT INTO Genres (GenreName) VALUES ('Afrofuturism');

select * from Genres order by GenreID;

-- These query is written by Neha
-- Insert queries for Publisher table
INSERT INTO Publishers (PublisherName)
SELECT DISTINCT Publisher
FROM sample_data;

INSERT INTO Publishers (PublisherName) VALUES ('Aether Publishing House');
INSERT INTO Publishers (PublisherName) VALUES ('Binary Stars Books');
INSERT INTO Publishers (PublisherName) VALUES ('Celestial Mapping Co.');
INSERT INTO Publishers (PublisherName) VALUES ('Dimensional Printworks');
INSERT INTO Publishers (PublisherName) VALUES ('Elemental Reads Publishing');
INSERT INTO Publishers (PublisherName) VALUES ('Forbidden Lore Press');
INSERT INTO Publishers (PublisherName) VALUES ('Graviton Media');
INSERT INTO Publishers (PublisherName) VALUES ('Horizon Line Books');
INSERT INTO Publishers (PublisherName) VALUES ('Interstellar Ink');
INSERT INTO Publishers (PublisherName) VALUES ('Labyrinth Literary');
INSERT INTO Publishers (PublisherName) VALUES ('Mythos Creations');
INSERT INTO Publishers (PublisherName) VALUES ('Nexus Book Group');
INSERT INTO Publishers (PublisherName) VALUES ('Quantum Quills Publishing');
INSERT INTO Publishers (PublisherName) VALUES ('Rift Valley Press');
INSERT INTO Publishers (PublisherName) VALUES ('Timefold Books');


select distinct * from Publishers ;

-- -- These query is written by Neha
-- Insert queries for Books table
INSERT INTO Books (
    Title, AuthorID, GenreID, PublishingYear,
    AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank
)
SELECT 
    temp.book_name,
    a.AuthorID,
    g.GenreID,
    temp.publishing_year,
    temp.book_average_rating,
    temp.book_ratings_count,
    p.PublisherID,
    temp.sale_price,
    temp.sales_rank
FROM sample_data temp
JOIN Authors a ON temp.author = a.AuthorName
JOIN Genres g ON temp.genre = g.GenreName
JOIN Publishers p ON temp.publisher = p.PublisherName;


INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ('Whispers of the Quantum Realm', 97, 5, 2024, 4.8, 120, 20, 15.99, 1);

INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ('Solar Flares and Shadows', 96, 7, 2024, 4.7, 85, 10, 12.99, 2);

INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ('Echoes from the Afrofuture', 95, 8, 2023, 4.9, 143, 9, 18.99, 3);

INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ('The Labyrinth of Time', 101, 6, 2024, 4.6, 97, 17, 13.99, 4);

INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ('Gardens Beyond the Galaxy', 102, 5, 2025, 4.5, 88, 15, 14.99, 5);

INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ('Chronicles of the Forgotten', 103, 4, 2023, 4.4, 76, 11, 16.99, 6);

INSERT INTO Authors (AuthorID, AuthorName, LanguageCode, AuthorRating)
VALUES (104, 'V. S. Naipaul', 'en', 'Expert');
INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ('The Enigma of Arrival', 104, 7, 2024, 4.2, 64, 13, 17.99, 7);

INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ('Beneath the Cosmic Seas', 99, 5, 2025, 4.3, 52, 16, 19.99, 8);

INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ("Lost Chronicles: Earth's Last Hope", 100, 6, 2024, 4.1, 120, 18, 15.49, 9);

INSERT INTO Books (Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank) 
VALUES ("The Final Frontier: A New Dawn", 98, 8, 2023, 4.6, 134, 19, 20.99, 10);


select * from Books;


-- These query is written by Isha
-- Insert queries for Transaction table
INSERT INTO Transactions (BookID ,GrossSales, PublisherRevenue, UnitsSold)
SELECT 
    b.BookID,
    temp.`gross_sales`,
    temp.`publisher_revenue`,
    temp.`units_Sold`
FROM 
    sample_data temp
JOIN
    Books b ON temp.`book_name` = b.Title;

INSERT INTO Books (BookID, Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank)
VALUES (64, 'Example Book Title', 101, 5, 2024, 4.1, 54321, 8, 19.99, 3);

-- Query by Mihir
-- Insert Authors
INSERT IGNORE INTO Authors (AuthorName, LanguageCode, AuthorRating)
VALUES 
  ('Haruki Murakami', 'ja', 'Expert'),
  ('Paulo Coelho', 'pt', 'Expert'),
  ('Margaret Atwood', 'en', 'Expert'),
  ('Chimamanda Adichie', 'en', 'Intermediate'),
  ('Stephen Hawking', 'en', 'Expert');

-- Insert Genres
INSERT IGNORE INTO Genres (GenreName)
VALUES 
  ('Philosophy'), 
  ('Fiction'), 
  ('Science'), 
  ('Biography');

-- Insert Publishers
INSERT IGNORE INTO Publishers (PublisherName)
VALUES 
  ('Penguin Books'), 
  ('HarperCollins'), 
  ('Random House');

-- Insert Books (IDs 64 to 73)

INSERT INTO Books (BookID, Title, AuthorID, GenreID, PublishingYear, AverageRating, RatingsCount, PublisherID, SalePrice, SalesRank)
VALUES
(60, 'Kafka on the Shore', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Haruki Murakami'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Fiction'), 2002, 4.3, 92000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'Penguin Books'), 14.99, 1),

(65, 'The Alchemist', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Paulo Coelho'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Philosophy'), 1993, 4.2, 150000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'HarperCollins'), 13.49, 2),

(66, 'The Handmaid\'s Tale', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Margaret Atwood'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Fiction'), 1985, 4.1, 117000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'Random House'), 16.50, 3),

(67, 'Half of a Yellow Sun', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Chimamanda Adichie'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Fiction'), 2006, 4.4, 81000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'Penguin Books'), 12.99, 4),

(68, 'A Brief History of Time', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Stephen Hawking'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Science'), 1988, 4.5, 165000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'Random House'), 18.00, 5),

(69, 'Blindness', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Paulo Coelho'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Fiction'), 1995, 4.0, 98000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'HarperCollins'), 11.99, 6),

(70, 'Norwegian Wood', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Haruki Murakami'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Fiction'), 1987, 4.2, 123000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'Penguin Books'), 10.99, 7),

(71, 'The Testaments', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Margaret Atwood'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Fiction'), 2019, 4.1, 71000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'Random House'), 17.99, 8),

(72, 'Purple Hibiscus', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Chimamanda Adichie'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Fiction'), 2003, 4.3, 65000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'Penguin Books'), 15.99, 9),

(73, 'The Universe in a Nutshell', (SELECT AuthorID FROM Authors WHERE AuthorName = 'Stephen Hawking'), 
     (SELECT GenreID FROM Genres WHERE GenreName = 'Science'), 2001, 4.6, 89000, 
     (SELECT PublisherID FROM Publishers WHERE PublisherName = 'Random House'), 19.99, 10);
     
UPDATE books
SET units = 100
WHERE units < 100 AND BookID IS NOT NULL;


 
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (64, 1919.40, 1151.64, 120);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (65, 1104.15, 662.49, 85);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (66, 2717.57, 1630.54, 143);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (67, 1357.03, 814.22, 97);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (68, 1319.12, 791.47, 88);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (69, 1287.24, 772.34, 76);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (70, 1151.36, 690.82, 64);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (71, 1039.68, 623.81, 52);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (72, 1858.80, 1115.28, 120);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (73, 2808.66, 1685.20, 134);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (64, 2398.80, 1439.28, 150);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (65, 1039.15, 623.49, 100);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (66, 2727.57, 1636.54, 148);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (67, 1377.03, 826.22, 99);
INSERT INTO Transactions (BookID, GrossSales, PublisherRevenue, UnitsSold) VALUES (68, 1329.12, 797.47, 89);


select * from transactions;

INSERT INTO admin (username, password)
VALUES ('root', 'root@123');


Select * from admin;

Select * from books;

ALTER TABLE books
ADD COLUMN units INT NOT NULL DEFAULT 0;
