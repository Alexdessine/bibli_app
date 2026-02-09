## Objectif

Optimiser les requêtes fréquentes via des index adaptés.

---

## Description

Créer des index sur :

- book_copies(book_id), book_copies(owner_user_id), book_copies(status)
- loan_requests(book_copy_id, status), loan_requests(requester_user_id)
- loans(book_copy_id, returned_at)
- book_reviews(book_id)
- user_location(lat, lng)
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
