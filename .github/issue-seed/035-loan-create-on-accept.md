
## Objectif

Créer un prêt (loans) quand une demande est acceptée et empêcher plusieurs prêts actifs sur un exemplaire.

---

## Description

À l’acceptation :

- créer loans (lié à la demande)
- passer book_copy.status = on_loan
- garantir “1 seul prêt actif par exemplaire” (transaction + vérification)
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

- Phase du projet concernée : Phase 2 — Backend
- Lien Figma / Doc / Brief (si applicable) :
