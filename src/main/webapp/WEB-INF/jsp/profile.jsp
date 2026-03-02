<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Mon Profil — EduForum</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="profile-header">
  <div class="container">
    <div style="display:flex;align-items:center;gap:20px;">
      <div class="profile-avatar-big">
        ${not empty sessionScope.user.prenom ? sessionScope.user.prenom.substring(0,1) : sessionScope.user.username.substring(0,1)}
      </div>
      <div class="profile-info">
        <h1>
          ${not empty sessionScope.user.prenom ? sessionScope.user.prenom : ''} ${not empty sessionScope.user.nom ? sessionScope.user.nom : sessionScope.user.username}
          <span class="badge-role">${sessionScope.user.role}</span>
        </h1>
        <p>${sessionScope.user.email}</p>
        <c:if test="${not empty sessionScope.user.filiere}">
          <p style="margin-top:4px;">${sessionScope.user.filiere} — ${sessionScope.user.niveau}</p>
        </c:if>
      </div>
    </div>
  </div>
</div>

<div class="container main-content">
  <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
  <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

  <div class="profile-grid">
    <div class="profile-sidebar">
      <div class="info-card">
        <h3>Informations</h3>
        <div class="info-row">
          <span class="info-label">CNE</span>
          <span class="info-value">${not empty sessionScope.user.cne ? sessionScope.user.cne : '—'}</span>
        </div>
        <div class="info-row">
          <span class="info-label">Filière</span>
          <span class="info-value">${not empty sessionScope.user.filiere ? sessionScope.user.filiere : '—'}</span>
        </div>
        <div class="info-row">
          <span class="info-label">Niveau</span>
          <span class="info-value">${not empty sessionScope.user.niveau ? sessionScope.user.niveau : '—'}</span>
        </div>
        <div class="info-row">
          <span class="info-label">Rôle</span>
          <span class="info-value">${sessionScope.user.role}</span>
        </div>
        <div class="info-row">
          <span class="info-label">Membre depuis</span>
          <span class="info-value"><fmt:formatDate value="${sessionScope.user.createdAt}" pattern="dd/MM/yyyy"/></span>
        </div>
      </div>
      <c:if test="${not empty sessionScope.user.bio}">
        <div class="info-card">
          <h3>Bio</h3>
          <p style="font-size:.88rem;color:#374151;line-height:1.6;">${sessionScope.user.bio}</p>
        </div>
      </c:if>
    </div>

    <div>
      <div class="form-card" style="margin-bottom:24px;">
        <h2>Modifier mon profil</h2>
        <form method="post" action="${pageContext.request.contextPath}/profile">
          <input type="hidden" name="action" value="updateProfile">
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Prénom</label>
              <input type="text" name="prenom" class="form-control" value="${sessionScope.user.prenom}">
            </div>
            <div class="form-group">
              <label class="form-label">Nom</label>
              <input type="text" name="nom" class="form-control" value="${sessionScope.user.nom}">
            </div>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Nom d'utilisateur</label>
              <input type="text" name="username" class="form-control" value="${sessionScope.user.username}" required>
            </div>
            <div class="form-group">
              <label class="form-label">Email</label>
              <input type="email" name="email" class="form-control" value="${sessionScope.user.email}" required>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Filière</label>
              <select name="filiere" class="form-control form-select">
                <option value="">--</option>
                <option ${sessionScope.user.filiere=='Génie Informatique'?'selected':''}>Génie Informatique</option>
                <option ${sessionScope.user.filiere=='Génie Électrique'?'selected':''}>Génie Électrique</option>
                <option ${sessionScope.user.filiere=='Génie Civil'?'selected':''}>Génie Civil</option>
                <option ${sessionScope.user.filiere=='Génie Mécanique'?'selected':''}>Génie Mécanique</option>
                <option ${sessionScope.user.filiere=='Commerce et Gestion'?'selected':''}>Commerce et Gestion</option>
                <option ${sessionScope.user.filiere=='Techniques de Management'?'selected':''}>Techniques de Management</option>
              </select>
            </div>
            <div class="form-group">
              <label class="form-label">Niveau</label>
              <select name="niveau" class="form-control form-select">
                <option value="">--</option>
                <option ${sessionScope.user.niveau=='1ère année'?'selected':''}>1ère année</option>
                <option ${sessionScope.user.niveau=='2ème année'?'selected':''}>2ème année</option>
                <option ${sessionScope.user.niveau=='3ème année'?'selected':''}>3ème année</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">CNE</label>
            <input type="text" name="cne" class="form-control" value="${sessionScope.user.cne}">
          </div>
          <div class="form-group">
            <label class="form-label">Bio (optionnel)</label>
            <textarea name="bio" class="form-control" rows="3">${sessionScope.user.bio}</textarea>
          </div>
          <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
        </form>
      </div>

      <div class="form-card">
        <h2>Changer le mot de passe</h2>
        <form method="post" action="${pageContext.request.contextPath}/profile">
          <input type="hidden" name="action" value="changePassword">
          <div class="form-group">
            <label class="form-label">Mot de passe actuel</label>
            <input type="password" name="oldPassword" class="form-control" required>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label">Nouveau mot de passe</label>
              <input type="password" name="newPassword" class="form-control" required minlength="4">
            </div>
            <div class="form-group">
              <label class="form-label">Confirmer</label>
              <input type="password" name="confirmPassword" class="form-control" required minlength="4">
            </div>
          </div>
          <button type="submit" class="btn btn-outline">Modifier le mot de passe</button>
        </form>
      </div>
    </div>
  </div>
</div>
<footer style="text-align:center;padding:24px;color:#94a3b8;font-size:.8rem;border-top:1px solid #dce3ef;margin-top:40px;">
  © 2026 EduForum — École Supérieure de Technologie, Agadir
</footer>
</body>
</html>
