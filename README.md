# ✍️ JEE-Blog — Guide de Configuration

## 🛠️ Prérequis
- JDK 11+
- Apache Tomcat 9 ou 10
- MySQL 8+
- IntelliJ IDEA (Community ou Ultimate)
- Maven

---

## ⚡ Démarrage en 5 étapes

### 1️⃣ Base de données MySQL
Ouvrez MySQL (phpMyAdmin ou Workbench) et exécutez le fichier :
```
database.sql
```
Cela crée la base `jee_blog` avec toutes les tables et un admin par défaut.

---

### 2️⃣ Configurer la connexion DB
Ouvrez le fichier :
```
src/main/java/dao/DBConnection.java
```
Modifiez si nécessaire :
```java
private static final String USER     = "root";       // votre user MySQL
private static final String PASSWORD = "";            // votre mot de passe MySQL
```

---

### 3️⃣ Configurer l'email (optionnel)
Pour la vérification par email, ouvrez :
```
src/main/java/utils/EmailUtil.java
```
Et remplissez votre email Gmail + mot de passe d'application.

> ⚠️ En mode développement, le lien de vérification s'affiche directement dans le message de succès de la page inscription. Donc vous pouvez tester sans configurer l'email.

---

### 4️⃣ Ouvrir dans IntelliJ IDEA

1. **File → Open** → sélectionner le dossier `JEE-Blog`
2. IntelliJ détecte automatiquement le `pom.xml` Maven
3. Attendre que Maven télécharge les dépendances
4. **Configurer Tomcat** :
   - Run → Edit Configurations → + → Tomcat Server → Local
   - Server : sélectionner votre Tomcat
   - Deployment → + → Artifact → `JEE-Blog:war exploded`
   - Application context : `/JEE-Blog`

---

### 5️⃣ Lancer le projet
- Cliquer sur **Run** (▶️) dans IntelliJ
- Ouvrir : `http://localhost:8080/JEE-Blog`

---

## 👤 Compte Admin par défaut
| Email | Mot de passe |
|-------|-------------|
| admin@blog.com | admin123 |

---

## 🗂️ Structure du Projet
```
JEE-Blog/
├── database.sql                    ← Script SQL à exécuter en premier
├── pom.xml                         ← Dépendances Maven
└── src/main/
    ├── java/
    │   ├── beans/                  ← User, Article, Comment
    │   ├── dao/                    ← DBConnection, UserDAO, ArticleDAO, CommentDAO
    │   ├── servlets/               ← Tous les contrôleurs HTTP
    │   ├── filters/                ← EncodingFilter, AuthFilter
    │   └── utils/                  ← EmailUtil
    ├── resources/
    │   ├── messages_fr.properties  ← Traductions français
    │   └── messages_en.properties  ← Traductions anglais
    └── webapp/
        ├── index.jsp               ← Redirection vers /articles
        └── WEB-INF/
            ├── web.xml
            └── jsp/
                ├── navbar.jsp      ← Barre de navigation (include)
                ├── login.jsp
                ├── register.jsp
                ├── articles.jsp
                ├── articleDetail.jsp
                ├── newArticle.jsp
                ├── editArticle.jsp
                └── profile.jsp
```

---

## 🌟 Fonctionnalités
- ✅ Inscription + vérification par email
- ✅ Connexion / Déconnexion avec session
- ✅ Gestion articles (CRUD)
- ✅ Gestion commentaires
- ✅ Gestion profil + changement de mot de passe
- ✅ Internationalisation (Français / English)
- ✅ Interface responsive avec Bootstrap 5

---

## 🌐 Hébergement gratuit recommandé
- **Aiven** (MySQL cloud gratuit)
- **Railway.app** (déploiement Java + MySQL)
- **Render.com** (serveur web gratuit)
