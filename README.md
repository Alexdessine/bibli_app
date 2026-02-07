
# React + Express + MySQL Docker Stack

Squelette d’application full-stack prêt pour le développement local avec Docker.

Ce projet fournit une base moderne et reproductible pour démarrer rapidement une application web complète.

---

# Variantes du template

Ce dépôt propose deux variantes :

## Branche `main` — CSS classique

Utilise des fichiers `.css`.

## Branche `sass` — Sass / SCSS

Utilise `.scss` avec compilation automatique via Vite.

Pour utiliser Sass :

<pre class="overflow-visible! px-0!" data-start="696" data-end="725"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>git checkout sass
</span></span></code></div></div></pre>

Pour rester en CSS :

<pre class="overflow-visible! px-0!" data-start="749" data-end="778"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>git checkout main
</span></span></code></div></div></pre>

---

# Stack technique

## Frontend

* React
* Vite (HMR)
* Proxy API `/api`
* Vitest + Testing Library

## Backend

* Node.js
* Express
* Nodemon
* Jest + Supertest

## Base de données

* MySQL 8
* Volume Docker pour la persistance

## Outils de développement

* phpMyAdmin
* Mailpit (mailcatcher)
* Docker & Docker Compose

## CI/CD

* GitHub Actions
* Tests exécutés automatiquement sur Pull Request

---

# Structure du projet

<pre class="overflow-visible! px-0!" data-start="1207" data-end="1515"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>project-root/
│
├── client/              # Frontend React (Vite)
│   ├── src/
│   ├── Dockerfile
│   ├── vite.</span><span>config</span><span>.js
│   └── vitest.</span><span>config</span><span>.js
│
├── server/              # Backend Express
│   ├── src/
│   ├── __tests__/
│   ├── Dockerfile
│   └── </span><span>package</span><span>.json
│
├── docker-compose.yml
└── README.md
</span></span></code></div></div></pre>

---

# Services Docker

## client

Frontend Vite.

URL :

<pre class="overflow-visible! px-0!" data-start="1573" data-end="1602"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>http:</span><span>//localhost:5173</span><span>
</span></span></code></div></div></pre>

Fonctions :

* HMR
* Proxy vers backend

---

## server

API Express.

URL :

<pre class="overflow-visible! px-0!" data-start="1679" data-end="1708"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>http:</span><span>//localhost:3000</span><span>
</span></span></code></div></div></pre>

Fonctions :

* Routes `/api`
* Connexion MySQL
* Envoi d’emails via Mailpit

---

## db (MySQL)

Port :

<pre class="overflow-visible! px-0!" data-start="1813" data-end="1825"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>3306</span><span>
</span></span></code></div></div></pre>

Variables typiques :

<pre class="overflow-visible! px-0!" data-start="1848" data-end="1955"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>MYSQL_DATABASE</span><span>=appdb
</span><span>MYSQL_USER</span><span>=appuser
</span><span>MYSQL_PASSWORD</span><span>=apppassword
</span><span>MYSQL_ROOT_PASSWORD</span><span>=rootpassword
</span></span></code></div></div></pre>

---

## phpMyAdmin

<pre class="overflow-visible! px-0!" data-start="1977" data-end="2006"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>http:</span><span>//localhost:8080</span><span>
</span></span></code></div></div></pre>

Permet :

* gestion des tables
* requêtes SQL
* import/export

---

## Mailpit

Interface web :

<pre class="overflow-visible! px-0!" data-start="2103" data-end="2132"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>http:</span><span>//localhost:8025</span><span>
</span></span></code></div></div></pre>

SMTP :

<pre class="overflow-visible! px-0!" data-start="2141" data-end="2173"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>host:</span><span></span><span>mailpit</span><span>
</span><span>port:</span><span></span><span>1025</span><span>
</span></span></code></div></div></pre>

---

# Lancement du projet

## Démarrer

<pre class="overflow-visible! px-0!" data-start="2216" data-end="2253"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>docker compose up --build
</span></span></code></div></div></pre>

---

## Arrêter

<pre class="overflow-visible! px-0!" data-start="2272" data-end="2303"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>docker compose down
</span></span></code></div></div></pre>

---

## Réinitialisation complète

<pre class="overflow-visible! px-0!" data-start="2340" data-end="2374"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>docker compose down -v
</span></span></code></div></div></pre>

---

# Communication entre services

Les services communiquent via leurs noms Docker.

Exemples :

Backend → MySQL

<pre class="overflow-visible! px-0!" data-start="2491" data-end="2518"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>host:</span><span></span><span>db</span><span>
</span><span>port:</span><span></span><span>3306</span><span>
</span></span></code></div></div></pre>

Backend → SMTP

<pre class="overflow-visible! px-0!" data-start="2535" data-end="2567"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>host:</span><span></span><span>mailpit</span><span>
</span><span>port:</span><span></span><span>1025</span><span>
</span></span></code></div></div></pre>

---

# Hot Reload

## Backend

Nodemon redémarre automatiquement.

## Frontend

Vite recharge automatiquement.

Sous Windows :

* `usePolling: true` dans Vite
* `nodemon --legacy-watch`

---

# Tests

## Backend

<pre class="overflow-visible! px-0!" data-start="2779" data-end="2830"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>docker compose run --</span><span>rm</span><span> server npm </span><span>test</span><span>
</span></span></code></div></div></pre>

Tests avec :

* Jest
* Supertest

---

## Frontend

<pre class="overflow-visible! px-0!" data-start="2883" data-end="2934"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-bash"><span><span>docker compose run --</span><span>rm</span><span> client npm </span><span>test</span><span>
</span></span></code></div></div></pre>

Tests avec :

* Vitest
* Testing Library

---

# CI GitHub Actions

À chaque Pull Request :

* installation des dépendances
* exécution des tests frontend
* exécution des tests backend
* échec du pipeline si un test échoue

Les tests peuvent être configurés comme obligatoires avant merge via :

<pre class="overflow-visible! px-0!" data-start="3231" data-end="3273"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>Settings</span><span> → Branch protection rules
</span></span></code></div></div></pre>

---

# Tests rapides manuels

## API

<pre class="overflow-visible! px-0!" data-start="3313" data-end="3357"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>GET http://localhost:3000/api/health
</span></span></code></div></div></pre>

---

## Base de données

Connexion via phpMyAdmin.

---

## Email

Envoyer un email via l’API et vérifier dans Mailpit.

---

# Bonnes pratiques

* ne pas utiliser root en production
* ne pas exposer MySQL en production
* utiliser `.env` pour les secrets
* séparer dev/prod

---

# Objectif du projet

Ce dépôt sert de :

* template full-stack moderne
* base de démarrage React + Node
* environnement d’apprentissage Docker
* base pour projets personnels ou professionnels

---

# État actuel

Projet volontairement minimal :

* pas d’authentification
* pas de logique métier avancée
* pas de schéma DB complexe

Il constitue une fondation pour construire une application complète.
