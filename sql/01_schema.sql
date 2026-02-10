-- =========================================================
-- 01_schema.sql
-- Objectif : 
--  - Créer les tables de la base de données bibli_app selon le MCD : 
--   - User
--   - Book
--   - Loan
--  - Ajouter les contraintes d'intégrité référentielle
-- =========================================================

USE bibli_app;

-- ---------------------------------------------------------
-- Suppression des tables si elles existent déjà
-- ---------------------------------------------------------
DROP TABLE IF EXISTS request_messages;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS loan_requests;
DROP TABLE IF EXISTS book_reviews;
DROP TABLE IF EXISTS book_copies;
DROP TABLE IF EXISTS book_categories;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS user_location;
DROP TABLE IF EXISTS users;

START TRANSACTION;

-- ---------------------------------------------------------
-- Création de la table users
-- ---------------------------------------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') NOT NULL DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- Création de la table user_location
-- ---------------------------------------------------------
CREATE TABLE user_location (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    lat DECIMAL(10, 8) NOT NULL,
    lng DECIMAL(11, 8) NOT NULL,
    geohash VARCHAR(12) NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- Création de la table books
-- ---------------------------------------------------------
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    authors_text VARCHAR(255) NULL,
    isbn10 VARCHAR(20) NULL UNIQUE,
    isbn13 VARCHAR(20) NULL UNIQUE,
    google_volume_id VARCHAR(50) NULL UNIQUE,
    cover_url VARCHAR(255) NULL,
    description TEXT,
    language VARCHAR(50) NULL,
    publication_date INT NULL,
    page_count INT NULL,
    created_by_user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by_user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- Création de la table categories
-- ---------------------------------------------------------
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- Création de la table book_categories
-- ---------------------------------------------------------
CREATE TABLE book_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    category_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- Création de la table book_copies
-- ---------------------------------------------------------
CREATE TABLE book_copies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    owner_user_id INT NOT NULL,
    condition_state ENUM('new', 'good', 'worn', 'damaged') NOT NULL DEFAULT 'good',
    owner_note DECIMAL(3, 2) NULL,
    status ENUM('available', 'loaned', 'reserved') NOT NULL DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (owner_user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- Création de la table book_reviews
-- ---------------------------------------------------------
CREATE TABLE book_reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    user_id INT NOT NULL,
    rating DECIMAL(3, 2) NOT NULL CHECK (rating >= 0 AND rating <= 5),
    comment TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- Création de la table loan_requests
-- ---------------------------------------------------------
CREATE TABLE loan_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_copy_id INT NOT NULL,
    requester_user_id INT NOT NULL,
    owner_user_id INT NOT NULL,
    status ENUM('pending', 'approved', 'rejected', 'cancelled') NOT NULL DEFAULT 'pending',
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    decided_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_copy_id) REFERENCES book_copies(id) ON DELETE CASCADE,
    FOREIGN KEY (requester_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (owner_user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- Création de la table loans
-- ---------------------------------------------------------
CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_copy_id INT NOT NULL,
    borrower_user_id INT NOT NULL,
    owner_user_id INT NOT NULL,
    loan_request_id INT NULL,
    loaned_at DATE NOT NULL,
    due_at DATE NOT NULL,
    return_date DATE NULL,
    status ENUM('active', 'returned', 'overdue') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_copy_id) REFERENCES book_copies(id) ON DELETE CASCADE,
    FOREIGN KEY (borrower_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (owner_user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (loan_request_id) REFERENCES loan_requests(id) ON DELETE SET NULL
);

-- ---------------------------------------------------------
-- Création de la table request_messages
-- ---------------------------------------------------------
CREATE TABLE request_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    loan_request_id INT NOT NULL,
    sender_user_id INT NOT NULL,
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (loan_request_id) REFERENCES loan_requests(id) ON DELETE CASCADE,
    FOREIGN KEY (sender_user_id) REFERENCES users(id) ON DELETE CASCADE
);

COMMIT;
