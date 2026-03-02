<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Nouveau Module — EduForum</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="page-header"><div class="header-inner"><div>
  <h1>Nouveau Module</h1>
  <p>Créer un nouveau module pédagogique</p>
</div></div></div>
<div class="container main-content">
  <div style="max-width:720px;margin:0 auto;">
    <div class="form-card">
      <h2>Informations du module</h2>
      <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
      <form method="post" action="${pageContext.request.contextPath}/modules">
        <input type="hidden" name="action" value="create">
        <div class="form-group">
          <label class="form-label">Titre du module *</label>
          <input type="text" name="titre" class="form-control" placeholder="ex: Programmation Orientée Objet" required>
        </div>
        <div class="form-group">
          <label class="form-label">Description *</label>
          <textarea name="description" class="form-control" rows="4" required
            placeholder="Présentation générale du module, objectifs pédagogiques..."></textarea>
        </div>
        <div class="form-group">
          <label class="form-label">Contenu du cours (optionnel)</label>
          <textarea name="contenu" class="form-control" rows="6"
            placeholder="Chapitres, plan du cours, ressources..."></textarea>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Filière</label>
            <select name="filiere" class="form-control form-select">
              <option value="">-- Toutes filières --</option>
              <option>Génie Informatique</option>
              <option>Génie Électrique</option>
              <option>Génie Civil</option>
              <option>Génie Mécanique</option>
              <option>Commerce et Gestion</option>
              <option>Techniques de Management</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label">Niveau</label>
            <select name="niveau" class="form-control form-select">
              <option value="">-- Tous niveaux --</option>
              <option>1ère année</option>
              <option>2ème année</option>
              <option>3ème année</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label">Semestre</label>
          <select name="semestre" class="form-control form-select" style="max-width:200px;">
            <option value="">--</option>
            <option value="1">Semestre 1</option>
            <option value="2">Semestre 2</option>
            <option value="3">Semestre 3</option>
            <option value="4">Semestre 4</option>
            <option value="5">Semestre 5</option>
            <option value="6">Semestre 6</option>
          </select>
        </div>
        <div class="form-actions">
          <button type="submit" class="btn btn-accent btn-lg">Publier le module</button>
          <a href="${pageContext.request.contextPath}/modules" class="btn btn-outline btn-lg">Annuler</a>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>
