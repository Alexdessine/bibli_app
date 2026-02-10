-- =========================================================
-- Bloc SQL : scénario complet "demande -> discussion -> prêt -> retour"
-- Hypothèses :
--  - 01_schema.sql déjà exécuté
--  - Tables existent : users, user_location, books, categories,
--    book_categories, book_copies, loan_requests, request_messages, loans
--  - Compatible MySQL 8+
-- =========================================================

USE bibli_app;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Nettoyage (ordre enfant -> parent)
DELETE FROM request_messages;
DELETE FROM loans;
DELETE FROM loan_requests;
DELETE FROM book_reviews;
DELETE FROM book_copies;
DELETE FROM book_categories;
DELETE FROM categories;
DELETE FROM books;
DELETE FROM user_location;
DELETE FROM users;

-- Reset AUTO_INCREMENT
ALTER TABLE request_messages AUTO_INCREMENT = 1;
ALTER TABLE loans AUTO_INCREMENT = 1;
ALTER TABLE loan_requests AUTO_INCREMENT = 1;
ALTER TABLE book_reviews AUTO_INCREMENT = 1;
ALTER TABLE book_copies AUTO_INCREMENT = 1;
ALTER TABLE book_categories AUTO_INCREMENT = 1;
ALTER TABLE categories AUTO_INCREMENT = 1;
ALTER TABLE books AUTO_INCREMENT = 1;
ALTER TABLE user_location AUTO_INCREMENT = 1;
ALTER TABLE users AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;

START TRANSACTION;

-- ---------------------------------------------------------
-- 1) Utilisateurs (propriétaire + emprunteur)
-- ---------------------------------------------------------
INSERT INTO users (name, email, password, role)
VALUES ('owner_user', 'owner.user@example.com', '$2b$10$N9qo8uLOickgx2ZMRZo5e.ejQ0s8AjtKoa6HgMHqmpYyqn1nVbWDa', 'user');
SET @owner_id := LAST_INSERT_ID();

INSERT INTO users (name, email, password, role)
VALUES ('borrower_user', 'borrower.user@example.com', '$2b$10$N9qo8uLOickgx2ZMRZo5e.ejQ0s8AjtKoa6HgMHqmpYyqn1nVbWDa', 'user');
SET @borrower_id := LAST_INSERT_ID();

-- ---------------------------------------------------------
-- 2) Localisations (proches)
-- ---------------------------------------------------------
INSERT INTO user_location (user_id, address, city, postal_code, country, lat, lng, geohash)
VALUES (@owner_id, '10 Rue Exemple', 'Paris', '75011', 'France', 48.857000, 2.375000, NULL);

INSERT INTO user_location (user_id, address, city, postal_code, country, lat, lng, geohash)
VALUES (@borrower_id, '20 Rue Exemple', 'Paris', '75012', 'France', 48.846500, 2.386500, NULL);

-- ---------------------------------------------------------
-- 3) Catégories
-- ---------------------------------------------------------
INSERT INTO categories (name, description) VALUES
('Roman', 'Œuvres de fiction narratives'),
('Science-fiction', 'Fiction basée sur des avancées scientifiques ou technologiques'),
('Informatique', 'Programmation, systèmes et technologies');

-- Récupérer IDs catégories sans supposer l’ordre
SELECT id INTO @cat_roman_id FROM categories WHERE name = 'Roman' LIMIT 1;
SELECT id INTO @cat_sf_id    FROM categories WHERE name = 'Science-fiction' LIMIT 1;
SELECT id INTO @cat_it_id    FROM categories WHERE name = 'Informatique' LIMIT 1;

-- ---------------------------------------------------------
-- 4) Livres
-- ---------------------------------------------------------
INSERT INTO books (
  title, authors_text, isbn10, isbn13, google_volume_id, cover_url,
  description, language, publication_date, page_count, created_by_user_id
) VALUES
('1984', 'George Orwell', '0451524934', '9780451524935', NULL, NULL,
 'Roman dystopique sur la surveillance et le totalitarisme.', 'fr', 1949, 328, @owner_id);

SET @book_1984_id := LAST_INSERT_ID();

INSERT INTO books (
  title, authors_text, isbn10, isbn13, google_volume_id, cover_url,
  description, language, publication_date, page_count, created_by_user_id
) VALUES
('Clean Code', 'Robert C. Martin', NULL, '9780132350884', NULL, NULL,
 'Guide de bonnes pratiques pour écrire du code lisible et maintenable.', 'en', 2008, 464, @owner_id);

SET @book_clean_code_id := LAST_INSERT_ID();

-- ---------------------------------------------------------
-- 5) Association livres -> catégories
-- ---------------------------------------------------------
INSERT INTO book_categories (book_id, category_id) VALUES
(@book_1984_id, @cat_roman_id),
(@book_1984_id, @cat_sf_id),
(@book_clean_code_id, @cat_it_id);

-- ---------------------------------------------------------
-- 6) Exemplaire physique possédé par le propriétaire
-- ---------------------------------------------------------
INSERT INTO book_copies (book_id, owner_user_id, condition_state, owner_note, status)
VALUES (@book_1984_id, @owner_id, 'good', 4.50, 'available');

SET @copy_1984_id := LAST_INSERT_ID();

-- ---------------------------------------------------------
-- 7) Demande d’emprunt (borrower -> owner)
-- ---------------------------------------------------------
INSERT INTO loan_requests (book_copy_id, requester_user_id, owner_user_id, status, requested_at, decided_at)
VALUES (@copy_1984_id, @borrower_id, @owner_id, 'pending', NOW(), NULL);

SET @loan_request_id := LAST_INSERT_ID();

-- ---------------------------------------------------------
-- 8) Discussion liée à la demande (messagerie contextuelle)
-- ---------------------------------------------------------
INSERT INTO request_messages (loan_request_id, sender_user_id, message, sent_at, read_at)
VALUES
(@loan_request_id, @borrower_id, 'Bonjour, est-ce que je peux emprunter ce livre cette semaine ?', NOW(), NULL),
(@loan_request_id, @owner_id, 'Oui, disponible. On se retrouve demain en fin de journée ?', NOW(), NULL),
(@loan_request_id, @borrower_id, 'Parfait, merci. Je confirme.', NOW(), NULL);

-- ---------------------------------------------------------
-- 9) Demande approuvée
-- ---------------------------------------------------------
UPDATE loan_requests
SET status = 'approved', decided_at = NOW()
WHERE id = @loan_request_id;

-- ---------------------------------------------------------
-- 10) Prêt actif + mise à jour du statut de l’exemplaire
-- ---------------------------------------------------------
INSERT INTO loans (
  book_copy_id, borrower_user_id, owner_user_id, loan_request_id,
  loaned_at, due_at, return_date, status
) VALUES (
  @copy_1984_id, @borrower_id, @owner_id, @loan_request_id,
  CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), NULL, 'active'
);

SET @loan_id := LAST_INSERT_ID();

UPDATE book_copies
SET status = 'loaned'
WHERE id = @copy_1984_id;

-- ---------------------------------------------------------
-- 11) Retour du livre (simulation)
-- ---------------------------------------------------------
UPDATE loans
SET status = 'returned', return_date = CURDATE()
WHERE id = @loan_id;

UPDATE book_copies
SET status = 'available'
WHERE id = @copy_1984_id;

COMMIT;

-- ---------------------------------------------------------
-- Contrôles rapides
-- ---------------------------------------------------------
SELECT 'users' AS table_name, COUNT(*) AS cnt FROM users
UNION ALL SELECT 'user_location', COUNT(*) FROM user_location
UNION ALL SELECT 'books', COUNT(*) FROM books
UNION ALL SELECT 'book_copies', COUNT(*) FROM book_copies
UNION ALL SELECT 'loan_requests', COUNT(*) FROM loan_requests
UNION ALL SELECT 'request_messages', COUNT(*) FROM request_messages
UNION ALL SELECT 'loans', COUNT(*) FROM loans;
