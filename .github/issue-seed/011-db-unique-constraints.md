# Contraintes d'unicité (email, ISBN, avis unique, N-N)

## Objectif

Ajouter les contraintes UNIQUE nécessaires à l’intégrité des données.

---

## Description

Ajouter des contraintes d’unicité :

- users.email unique
- books.isbn (si présent) unique
- books.google_volume_id (si présent) unique
- book_reviews (book_id, user_id) unique
- book_categories unique sur le couple (book_id, category_id)
  Préciser le contexte et la phase du projet concernée.

---

## Tâches à réaliser

- [ ] Analyse du besoin
- [ ] Implémentation
- [ ] Tests
- [ ] Documentation

---

## Critères d’acceptation

- [ ] La fonctionnalité répond au besoin décrit
- [ ] Le code est lisible et commenté
- [ ] Aucun impact négatif sur l’existant
- [ ] Conforme aux exigences du projet

---

## Références

- Phase du projet concernée : Phase 1 — Base de données
- Lien Figma / Doc / Brief (si applicable) :
