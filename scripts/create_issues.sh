#!/usr/bin/env bash
set -euo pipefail

# --- Pré-requis ---
command -v gh >/dev/null 2>&1 || { echo "Erreur: gh n'est pas installé."; exit 1; }

# Vérifie l'auth GitHub
if ! gh auth status >/dev/null 2>&1; then
  echo "Erreur: tu n'es pas connecté à GitHub CLI. Lance: gh auth login"
  exit 1
fi

# Vérifie qu'on est dans un repo avec remote GitHub
if ! gh repo view >/dev/null 2>&1; then
  echo "Erreur: ce dossier ne semble pas être un repo GitHub (ou remote manquant)."
  echo "Vérifie avec: git remote -v"
  exit 1
fi

SEED_DIR=".github/issue-seed"
if [ ! -d "$SEED_DIR" ]; then
  echo "Erreur: dossier introuvable: $SEED_DIR"
  exit 1
fi

# --- Helper ---
create_issue () {
  local title="$1"
  local file="$2"
  local labels="$3"

  if [ ! -f "$file" ]; then
    echo "Erreur: fichier introuvable: $file"
    exit 1
  fi

  echo "Création: $title"
  gh issue create \
    --title "$title" \
    --body-file "$file" \
    --label "$labels" >/dev/null

  echo "OK: $title"
}

# --- Phase 0 ---
create_issue "Phase 0 — Initialiser la structure du projet (monorepo)" \
  "$SEED_DIR/000-init-project-structure.md" \
  "feature,phase:0-init,devops"

create_issue "Phase 0 — Conventions (noms, statuts, erreurs API, commits)" \
  "$SEED_DIR/001-define-conventions.md" \
  "documentation,phase:0-init"

create_issue "Phase 0 — Standardiser le .env (client/server/compose)" \
  "$SEED_DIR/002-env-standardisation.md" \
  "feature,phase:0-init,devops"

# --- Phase 1 (DB) ---
create_issue "Phase 1 — DDL : créer toutes les tables (schéma initial)" \
  "$SEED_DIR/010-db-schema-ddl.md" \
  "feature,phase:1-db,db"

create_issue "Phase 1 — Contraintes d’unicité (email, ISBN, avis unique, N–N)" \
  "$SEED_DIR/011-db-unique-constraints.md" \
  "feature,phase:1-db,db"

create_issue "Phase 1 — Index de performance (recherche / filtres / proximité)" \
  "$SEED_DIR/012-db-indexes.md" \
  "feature,phase:1-db,db"

create_issue "Phase 1 — Seed : catégories + données de démo" \
  "$SEED_DIR/013-db-seed-data.md" \
  "feature,phase:1-db,db"

create_issue "Phase 1 — Documenter règles métier (statuts, transitions, contraintes)" \
  "$SEED_DIR/014-db-business-rules-documentation.md" \
  "documentation,phase:1-db,db"

# --- Phase 2 (Backend) ---
create_issue "Phase 2 — tailwind API + routes de base + healthchecks" \
  "$SEED_DIR/020-api-tailwind-healthcheck.md" \
  "feature,phase:2-backend,api"

create_issue "Phase 2 — Connexion MySQL (pool) + gestion erreurs standard" \
  "$SEED_DIR/021-api-db-connection-and-error-handling.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Auth : register (création user + hash password)" \
  "$SEED_DIR/022-auth-register.md" \
  "feature,phase:2-backend,api,security"

create_issue "Phase 2 — Auth : login + JWT + middleware d’accès" \
  "$SEED_DIR/023-auth-login-jwt.md" \
  "feature,phase:2-backend,api,security"

create_issue "Phase 2 — Profil : GET /me (données publiques vs privées)" \
  "$SEED_DIR/024-user-profile-me.md" \
  "feature,phase:2-backend,api"

create_issue "Phase 2 — Localisation : PUT /me/location (approx + validations)" \
  "$SEED_DIR/025-user-location.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Catalogue : GET /books (recherche + pagination) & GET /books/:id" \
  "$SEED_DIR/026-books-list-and-detail.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Catégories : GET /categories + association livre-catégorie" \
  "$SEED_DIR/027-categories-management.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Google Books : endpoint de recherche (backend)" \
  "$SEED_DIR/028-google-books-search.md" \
  "feature,phase:2-backend,api,external"

create_issue "Phase 2 — Books : POST /books (création + enrichissement Google Books)" \
  "$SEED_DIR/029-books-create-with-enrichment.md" \
  "feature,phase:2-backend,api,db,external"

create_issue "Phase 2 — Exemplaires : POST /book-copies + gestion owner (CRUD minimal)" \
  "$SEED_DIR/030-book-copies-management.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Recherche proximité : GET /books/nearby (copies + distance)" \
  "$SEED_DIR/031-books-nearby-search.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Demandes : POST /loan-requests (création + validations)" \
  "$SEED_DIR/032-loan-request-create.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Messagerie contextuelle : messages liés à une demande" \
  "$SEED_DIR/033-loan-request-messaging.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Workflow demande : accept / reject / cancel (+ transitions)" \
  "$SEED_DIR/034-loan-request-workflow.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Création loan à l’acceptation + verrou “1 prêt actif / exemplaire”" \
  "$SEED_DIR/035-loan-create-on-accept.md" \
  "feature,phase:2-backend,api,db,tests"

create_issue "Phase 2 — Retour : POST /loans/:id/return (historique conservé)" \
  "$SEED_DIR/036-loan-return.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Avis : POST/GET /books/:id/reviews (1 avis/user/livre)" \
  "$SEED_DIR/037-book-reviews.md" \
  "feature,phase:2-backend,api,db"

create_issue "Phase 2 — Documentation API : Swagger/OpenAPI" \
  "$SEED_DIR/038-api-swagger-documentation.md" \
  "documentation,phase:2-backend,api"

create_issue "Phase 2 — Tests API (règles critiques : auth, demande→prêt, avis unique)" \
  "$SEED_DIR/039-api-tests-core-rules.md" \
  "feature,phase:2-backend,api,tests"

# --- Phase 3 (Frontend) ---
create_issue "Phase 3 — Front : routing + layout mobile-first + navigation" \
  "$SEED_DIR/040-front-layout-routing.md" \
  "feature,phase:3-frontend,front"

create_issue "Phase 3 — Auth UI : register/login + stockage token + routes protégées" \
  "$SEED_DIR/041-front-auth-ui.md" \
  "feature,phase:3-frontend,front,security"

create_issue "Phase 3 — Profil : afficher / éditer localisation (géoloc navigateur)" \
  "$SEED_DIR/042-front-profile-location.md" \
  "feature,phase:3-frontend,front"

create_issue "Phase 3 — Catalogue : liste + détail livre + avis" \
  "$SEED_DIR/043-front-books-list-and-detail.md" \
  "feature,phase:3-frontend,front"

create_issue "Phase 3 — Ajouter une œuvre : recherche Google Books + création book" \
  "$SEED_DIR/044-front-book-create-google-books.md" \
  "feature,phase:3-frontend,front,external"

create_issue "Phase 3 — “Je possède ce livre” : gestion book_copies (multi-exemplaires)" \
  "$SEED_DIR/045-front-book-copies.md" \
  "feature,phase:3-frontend,front"

create_issue "Phase 3 — Nearby : afficher exemplaires proches (liste + carte MVP)" \
  "$SEED_DIR/046-front-nearby-map.md" \
  "feature,phase:3-frontend,front"

create_issue "Phase 3 — Demande : créer une loan_request (message initial)" \
  "$SEED_DIR/047-front-loan-request-create.md" \
  "feature,phase:3-frontend,front"

create_issue "Phase 3 — Messagerie demande : fil + envoi message (polling MVP)" \
  "$SEED_DIR/048-front-loan-request-messaging.md" \
  "feature,phase:3-frontend,front"

create_issue "Phase 3 — Requests : vues “envoyées / reçues” + actions (accept/reject/cancel)" \
  "$SEED_DIR/049-front-loan-requests-management.md" \
  "feature,phase:3-frontend,front"

create_issue "Phase 3 — Loans : prêts en cours + action retour" \
  "$SEED_DIR/050-front-loans-management.md" \
  "feature,phase:3-frontend,front"

create_issue "Phase 3 — Reviews UI : poster note/commentaire + afficher liste" \
  "$SEED_DIR/051-front-book-reviews.md" \
  "feature,phase:3-frontend,front"

# --- Phase 4 (Intégration) ---
create_issue "Phase 4 — Docker Compose “full dev” (client + server + db + outils)" \
  "$SEED_DIR/060-devops-docker-compose-full.md" \
  "feature,phase:4-integration,devops"

create_issue "Phase 4 — CORS + config env (dev/prod)" \
  "$SEED_DIR/061-integration-cors-env.md" \
  "feature,phase:4-integration,api,front"

create_issue "Phase 4 — Sécurité minimale (validation entrées + rate-limit auth)" \
  "$SEED_DIR/062-security-validation-rate-limit.md" \
  "feature,phase:4-integration,security,api"

create_issue "Phase 4 — Logs structurés (requêtes + erreurs)" \
  "$SEED_DIR/063-api-logging.md" \
  "feature,phase:4-integration,api"

create_issue "Phase 4 — README final (setup, commandes, flux métier, endpoints)" \
  "$SEED_DIR/064-readme-final.md" \
  "documentation,phase:4-integration"

# --- Phase 5 (V2) ---
create_issue "Phase 5 — Notifications (in-app / email via mailpit)" \
  "$SEED_DIR/070-v2-notifications.md" \
  "feature,phase:5-v2,api"

create_issue "Phase 5 — Recherche avancée (multi-critères + suggestions)" \
  "$SEED_DIR/071-v2-advanced-search.md" \
  "feature,phase:5-v2,api,front"

create_issue "Phase 5 — Modération (signalements / blocage utilisateur)" \
  "$SEED_DIR/072-v2-moderation.md" \
  "feature,phase:5-v2,api,security"

create_issue "Phase 5 — Réputation (score prêteur/emprunteur)" \
  "$SEED_DIR/073-v2-reputation-system.md" \
  "feature,phase:5-v2,api,db"

create_issue "Phase 5 — Optimisation géoloc (geohash / clustering / perf)" \
  "$SEED_DIR/074-v2-geolocation-optimisation.md" \
  "feature,phase:5-v2,api,db"

echo "Toutes les issues ont été créées."
