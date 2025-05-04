-- Create database LibraryManagementSystem;
-- The table is created by Mihir
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);


CREATE TABLE IF NOT EXISTS admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE sample_data (
    id INT PRIMARY KEY,
    publishing_year YEAR,
    book_name VARCHAR(255),
    author VARCHAR(255),
    language_code VARCHAR(10),
    author_rating VARCHAR(50),
    book_average_rating FLOAT,
    book_ratings_count INT,
    genre VARCHAR(100),
    gross_sales FLOAT,
    publisher_revenue FLOAT,
    sale_price FLOAT,
    sales_rank INT,
    publisher VARCHAR(255),
    units_sold INT
);
-- Authors Table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(255) NOT NULL,
    LanguageCode VARCHAR(10),
    AuthorRating VARCHAR(20) NOT NULL
);

-- The table is created by Mihir
-- Genres Table
CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(255) NOT NULL
);

-- The table is created by Mihir
-- Publishers Table
CREATE TABLE Publishers (
    PublisherID INT AUTO_INCREMENT PRIMARY KEY,
    PublisherName VARCHAR(255) NOT NULL
);

-- The table is created by Mihir
-- Books Table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    GenreID INT,
    PublishingYear INT,
    AverageRating DECIMAL(3,2) NOT NULL,
    RatingsCount INT,
    PublisherID INT,
    SalePrice DECIMAL(5,2),
    SalesRank INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
    FOREIGN KEY (PublisherID) REFERENCES Publishers(PublisherID)
);

-- The table is created by Isha
-- Transactions Table
CREATE TABLE Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    GrossSales DECIMAL(10,2) NOT NULL,
    PublisherRevenue DECIMAL(10,2),
    UnitsSold INT NOT NULL,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Constraints are given by Mihir
-- Unique Constraint on AuthorName in Authors Table
ALTER TABLE Authors ADD CONSTRAINT UQ_AuthorName UNIQUE (AuthorName);

-- Unique Constraint on GenreName in Genres Table
ALTER TABLE Genres ADD CONSTRAINT UQ_GenreName UNIQUE (GenreName);

-- Unique Constraint on PublisherName in Publishers Table
ALTER TABLE Publishers ADD CONSTRAINT UQ_PublisherName UNIQUE (PublisherName);

-- Default Constraint on PublisherRevenue in Transactions Table
ALTER TABLE Transactions ALTER COLUMN PublisherRevenue SET DEFAULT 0.00;
