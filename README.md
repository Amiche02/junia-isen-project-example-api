# 🚀 Shop-App : Développement et Déploiement sur Azure

## 📝 Objectif du Projet

Le but de ce projet est de développer une **API REST** pour une application de type **Shop-App**, déployer son infrastructure sur **Azure** avec **Terraform**, et configurer un pipeline **CI/CD** via **GitHub Actions**. Le projet inclut également des améliorations pour garantir la qualité et la sécurité tout en respectant les bonnes pratiques.

---

## 📋 Table des Matières

1. [Fonctionnalités de l'API]
2. [Structure de la Base de Données]
3. [Infrastructure Azure avec Terraform]
4. [Pipeline CI/CD]
5. [Améliorations Bonus]
6. [Structure du Projet]
7. [Instructions d'Installation]
8. [Licence]

---

## 🌐 Fonctionnalités de l'API

### Routes Principales

| **Méthode** | **Route**  | **Description**                             |
| ----------- | ---------- | ------------------------------------------- |
| `GET`       | `/`        | Retourne un message de bienvenue.           |
| `GET`       | `/items`   | Retourne la liste des articles disponibles. |
| `GET`       | `/baskets` | Retourne les paniers des utilisateurs.      |
| `GET`       | `/users`   | Retourne les informations des utilisateurs. |

### Routes CRUD Avancées

| **Méthode** | **Route**      | **Description**                             |
| ----------- | -------------- | ------------------------------------------- |
| `POST`      | `/items`       | Ajouter un nouvel article.                  |
| `POST`      | `/baskets`     | Ajouter un article au panier.               |
| `DELETE`    | `/baskets/:id` | Supprimer un article du panier.             |
| `PUT`       | `/users/:id`   | Modifier les informations d'un utilisateur. |

### Sécurité

- **Authentification JWT** pour protéger les routes sensibles (`/baskets`, `/users`).
- Middleware JWT pour sécuriser les accès.

---

## 🗄️ Structure de la Base de Données

### Tables

1. **`users`** : Stocke les informations des utilisateurs.
2. **`items`** : Stocke les articles disponibles à l’achat.
3. **`baskets`** : Associe des utilisateurs à leurs articles avec les quantités.

### Relations

- **`users ↔ baskets`** : Un utilisateur peut avoir plusieurs paniers.
- **`items ↔ baskets`** : Un panier peut contenir plusieurs articles.

---

## ☁️ Infrastructure Azure avec Terraform

### Ressources Provisionnées

1. **Azure App Service** : Héberger l'API via un conteneur Docker.
2. **Base de Données Azure PostgreSQL** : Stocker les données de l'application.
3. **Virtual Network (VNet)** : Isolation des ressources pour la sécurité.
4. **Azure Key Vault** : Gestion des secrets (mots de passe, clés).
5. **Azure Log Analytics** _(optionnel)_ : Monitoring et logs.
6. **Azure Storage Account** _(optionnel)_ : Backups automatiques.

### Structure des Modules Terraform

```
infrastructure/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules/
    ├── app_service/
    ├── database/
    ├── vnet/
    └── key_vault/
```

---

## ⚙️ Pipeline CI/CD avec GitHub Actions

### Fonctionnalités du Pipeline

1. **Lors des Pull Requests :**

   - Exécuter les tests unitaires.
   - Vérifier la qualité du code.

2. **Lors d'un Merge dans `main` :**
   - Construire une image Docker pour l'API.
   - Publier l'image Docker dans un registre (GitHub Packages ou Azure Container Registry).
   - Déployer automatiquement l'API sur Azure App Service.

### Fichier de Workflow

```
.github/
└── workflows/
    └── ci-cd.yml
```

---

## ⭐ Améliorations Bonus

1. **Notifications** : Alertes Slack ou Email pour les succès ou échecs.
2. **Multi-environnements** : Configuration des environnements `staging` et `production`.
3. **Monitoring** : Surveillance des logs et performances avec Azure Monitor.
4. **Tests E2E** : Intégration de tests de bout en bout.
5. **Documentation** : Utilisation de **Swagger** pour documenter l'API.

---

## 📂 Structure du Projet

```
shop-app/
├── main.go
├── routes/
│   ├── auth.go
│   ├── items.go
│   ├── baskets.go
│   └── users.go
├── controllers/
│   ├── auth.go
│   ├── items.go
│   ├── baskets.go
│   └── users.go
├── middleware/
│   └── auth.go
├── models/
│   ├── user.go
│   ├── item.go
│   └── basket.go
├── database/
│   └── db.go
├── utils/
│   ├── jwt.go
│   └── responses.go
├── infrastructure/
│   ├── main.tf
│   └── modules/
├── Dockerfile
├── .env
├── .gitignore
└── .github/
    └── workflows/
        └── ci-cd.yml
```

---

## 🚀 Instructions d'Installation

### Prérequis

- **Go** installé (`v1.16` ou supérieur)
- **Docker** installé
- **Terraform** installé
- **Azure CLI** configuré
- **Git**

### Étapes

1. **Cloner le dépôt :**

   ```bash
   git clone https://github.com/username/shop-app.git
   cd shop-app
   ```

2. **Configurer les variables d'environnement :**

   ```bash
   cp .env.example .env
   ```

3. **Construire l'image Docker :**

   ```bash
   docker build -t shop-app .
   ```

4. **Exécuter le conteneur :**

   ```bash
   docker run -p 8080:8080 --env-file .env shop-app
   ```

5. **Accéder à l'API :**
   ```bash
   http://localhost:8080
   ```

🎯 **Bon développement !**
