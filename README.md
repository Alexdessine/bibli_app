# React + Express + MySQL Docker Stack

Ce projet est un squelette d’application full-stack prêt pour le développement local avec Docker.

Il combine :

* Frontend React (Vite)
* Backend Node.js + Express
* Base de données MySQL
* Interface de gestion phpMyAdmin
* Serveur SMTP de test Mailpit (mailcatcher)
* Orchestration via Docker Compose

L’objectif est de disposer d’un environnement de développement complet, isolé et reproductible.

---

# Stack technique

## Frontend

* React
* Vite (hot module replacement)
* Appels API via proxy `/api`

## Backend

* Node.js
* Express
* Nodemon pour le rechargement automatique

## Base de données

* MySQL 8
* Volume Docker pour la persistance des données

## Outils de développement

* phpMyAdmin (gestion web de la base de données)
* Mailpit (capture d’emails de test)
* Docker et Docker Compose

---

# Structure du projet

<pre class="overflow-visible! px-0!" data-start="994" data-end="1258"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>project-root/
│
├── client/              </span><span># Frontend React (Vite)</span><span>
│   ├── src/
│   ├── Dockerfile
│   └── vite.config.js
│
├── server/              </span><span># Backend Express</span><span>
│   ├── src/
│   ├── Dockerfile
│   └── package.json
│
├── docker-compose.yml
└── README.md
</span></span></code></div></div></pre>

---

# Services Docker

## client

Serveur de développement Vite pour React.

Port :

<pre class="overflow-visible! px-0!" data-start="1344" data-end="1373"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>http:</span><span>//localhost:5173</span><span>
</span></span></code></div></div></pre>

Fonctions :

* rechargement automatique (HMR)
* proxy des requêtes API vers le backend

---

## server

API Express.

Port :

<pre class="overflow-visible! px-0!" data-start="1502" data-end="1531"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>http:</span><span>//localhost:3000</span><span>
</span></span></code></div></div></pre>

Fonctions :

* routes `/api`
* connexion MySQL
* envoi d’emails via Mailpit

---

## db (MySQL)

Port :

<pre class="overflow-visible! px-0!" data-start="1642" data-end="1654"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>3306</span><span>
</span></span></code></div></div></pre>

Variables d’environnement typiques :

<pre class="overflow-visible! px-0!" data-start="1693" data-end="1800"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>MYSQL_DATABASE</span><span>=appdb
</span><span>MYSQL_USER</span><span>=appuser
</span><span>MYSQL_PASSWORD</span><span>=apppassword
</span><span>MYSQL_ROOT_PASSWORD</span><span>=rootpassword
</span></span></code></div></div></pre>

Les données sont persistées via un volume Docker.

---

## phpMyAdmin

Interface web pour MySQL :

<pre class="overflow-visible! px-0!" data-start="1901" data-end="1930"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>http:</span><span>//localhost:8080</span><span>
</span></span></code></div></div></pre>

Permet :

* visualiser les tables
* exécuter des requêtes SQL
* importer et exporter des données

---

## Mailpit

Serveur SMTP de test.

Interface web :

<pre class="overflow-visible! px-0!" data-start="2091" data-end="2120"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>http:</span><span>//localhost:8025</span><span>
</span></span></code></div></div></pre>

Configuration SMTP :

<pre class="overflow-visible! px-0!" data-start="2143" data-end="2175"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>host:</span><span></span><span>mailpit</span><span>
</span><span>port:</span><span></span><span>1025</span><span>
</span></span></code></div></div></pre>

Permet :

* capturer les emails envoyés par l’application
* tester les fonctionnalités d’email sans envoyer de vrais messages

---

# Lancement du projet

## Build et démarrage

<pre class="overflow-visible! px-0!" data-start="2358" data-end="2391"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>docker compose up </span><span>--build</span><span>
</span></span></code></div></div></pre>

---

## Arrêt

<pre class="overflow-visible! px-0!" data-start="2408" data-end="2435"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>docker</span><span> compose down
</span></span></code></div></div></pre>

---

## Réinitialisation complète (suppression des volumes)

<pre class="overflow-visible! px-0!" data-start="2498" data-end="2528"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>docker</span><span> compose down -v
</span></span></code></div></div></pre>

---

# Communication entre services

Dans Docker Compose, chaque service est accessible par son nom.

Exemples :

* le backend accède à MySQL via l’hôte `db`
* le backend accède au SMTP via l’hôte `mailpit`

Exemple de configuration MySQL côté Node.js :

<pre class="overflow-visible! px-0!" data-start="2787" data-end="2814"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>host:</span><span></span><span>db</span><span>
</span><span>port:</span><span></span><span>3306</span><span>
</span></span></code></div></div></pre>

Exemple de configuration SMTP :

<pre class="overflow-visible! px-0!" data-start="2848" data-end="2880"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>host:</span><span></span><span>mailpit</span><span>
</span><span>port:</span><span></span><span>1025</span><span>
</span></span></code></div></div></pre>

---

# Hot reload

## Backend

Nodemon redémarre automatiquement le serveur lors de changements de fichiers.

## Frontend

Vite recharge automatiquement le navigateur lors des modifications.

En cas de problème sous Windows :

* activer le polling dans Vite
* utiliser `nodemon --legacy-watch`

---

# Tests rapides

## Test API

<pre class="overflow-visible! px-0!" data-start="3212" data-end="3256"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(var(--sticky-padding-top)+9*var(--spacing))]"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre!"><span><span>GET http://localhost:3000/api/health
</span></span></code></div></div></pre>

---

## Test base de données

Connexion via phpMyAdmin.

---

## Test email

Envoyer un email via l’API et vérifier sa présence dans l’interface Mailpit.

---

# Bonnes pratiques

* éviter l’utilisateur root en production
* ne pas exposer MySQL publiquement en production
* utiliser un fichier `.env` pour les secrets
* séparer les configurations développement et production

---

# Objectif du projet

Ce dépôt sert de :

* base de démarrage full-stack
* environnement d’apprentissage Docker
* template pour projets React + Node.js

---

# État actuel

Le projet est volontairement minimal :

* pas d’authentification
* pas de schéma de base de données avancé
* pas de logique métier complexe

Il sert de fondation pour construire une application plus complète.
