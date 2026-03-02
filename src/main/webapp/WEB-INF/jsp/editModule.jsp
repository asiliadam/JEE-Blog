<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Modifier Module — EduForum</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="page-header"><div class="header-inner"><div>
  <h1>Modifier le Module</h1>
  <p>${module.titre}</p>
</div></div></div>
<div class="container main-content">
  <div style="max-width:720px;margin:0 auto;">
    <div class="form-card">
      <h2>Modifier les informations</h2>
      <form method="post" action="${pageContext.request.contextPath}/modules">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${module.id}">
        <div class="form-group">
          <label class="form-label">Titre *</label>
          <input type="text" name="titre" class="form-control" value="${module.titre}" required>
        </div>
        <div class="form-group">
          <label class="form-label">Description *</label>
          <textarea name="description" class="form-control" rows="4" required>${module.description}</textarea>
        </div>
        <div class="form-group">
          <label class="form-label">Contenu du cours</label>
          <textarea name="contenu" class="form-control" rows="6">${module.contenu}</textarea>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Filière</label>
            <select name="filiere" class="form-control form-select">
              <option value="">-- Toutes filières --</option>
              <option ${module.filiere=='Génie Informatique'?'selected':''}>Génie Informatique</option>
              <option ${module.filiere=='Génie Électrique'?'selected':''}>Génie Électrique</option>
              <option ${module.filiere=='Génie Civil'?'selected':''}>Génie Civil</option>
              <option ${module.filiere=='Génie Mécanique'?'selected':''}>Génie Mécanique</option>
              <option ${module.filiere=='Commerce et Gestion'?'selected':''}>Commerce et Gestion</option>
              <option ${module.filiere=='Techniques de Management'?'selected':''}>Techniques de Management</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label">Niveau</label>
            <select name="niveau" class="form-control form-select">
              <option value="">-- Tous niveaux --</option>
              <option ${module.niveau=='1ère année'?'selected':''}>1ère année</option>
              <option ${module.niveau=='2ème année'?'selected':''}>2ème année</option>
              <option ${module.niveau=='3ème année'?'selected':''}>3ème année</option>
            </select>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label">Semestre</label>
          <select name="semestre" class="form-control form-select" style="max-width:200px;">
            <option value="">--</option>
            <c:forEach begin="1" end="6" var="s">
              <option value="${s}" ${module.semestre==s?'selected':''}>Semestre ${s}</option>
            </c:forEach>
          </select>
        </div>
        <div class="form-actions">
          <button type="submit" class="btn btn-primary btn-lg">Enregistrer</button>
          <a href="${pageContext.request.contextPath}/modules?action=view&id=${module.id}" class="btn btn-outline btn-lg">Annuler</a>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>
