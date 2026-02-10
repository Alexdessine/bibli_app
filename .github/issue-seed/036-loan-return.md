# Retour : POST /loans/:id/return (historique conservé)

## Objectif

Clôturer un prêt et remettre l’exemplaire disponible.

---

## Description

Créer POST /loans/:id/return :

- mettre returned_at
- repasser book_copy.status=available
- conserver l’historique
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
