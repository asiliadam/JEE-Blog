<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="lang" value="${empty sessionScope.lang ? 'fr' : sessionScope.lang}"/>
<!DOCTYPE html>
<html lang="${lang}">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title><c:choose><c:when test="${lang=='en'}">Register</c:when><c:otherwise>Inscription</c:otherwise></c:choose> — EduForum EST Agadir</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-page">
  <div class="auth-card" style="max-width:580px;">
    <div class="auth-card-header">
      <div class="logo">⬡</div>
      <h2><c:choose><c:when test="${lang=='en'}">Create Account</c:when><c:otherwise>Créer un compte</c:otherwise></c:choose></h2>
      <p><c:choose><c:when test="${lang=='en'}">Join EST Agadir academic space</c:when><c:otherwise>Rejoignez l'espace pédagogique EST Agadir</c:otherwise></c:choose></p>
    </div>
    <div class="auth-card-body">
      <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
      <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
      <form method="post" action="${pageContext.request.contextPath}/register">
        <div class="form-row">
          <div class="form-group">
            <label class="form-label"><c:choose><c:when test="${lang=='en'}">First Name</c:when><c:otherwise>Prénom</c:otherwise></c:choose></label>
            <input type="text" name="prenom" class="form-control" required>
          </div>
          <div class="form-group">
            <label class="form-label"><c:choose><c:when test="${lang=='en'}">Last Name</c:when><c:otherwise>Nom</c:otherwise></c:choose></label>
            <input type="text" name="nom" class="form-control" required>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label"><c:choose><c:when test="${lang=='en'}">Student ID (CNE)</c:when><c:otherwise>Numéro Étudiant (CNE)</c:otherwise></c:choose></label>
          <input type="text" name="cne" class="form-control" placeholder="ex: G134567890" required>
        </div>
        <div class="form-row">
          <div class="form-group">
            <label class="form-label"><c:choose><c:when test="${lang=='en'}">Field of Study</c:when><c:otherwise>Filière</c:otherwise></c:choose></label>
            <select name="filiere" class="form-control form-select" required>
              <option value=""><c:choose><c:when test="${lang=='en'}">-- Choose --</c:when><c:otherwise>-- Choisir --</c:otherwise></c:choose></option>
              <option value="Génie Informatique">Génie Informatique</option>
              <option value="Génie Électrique">Génie Électrique</option>
              <option value="Génie Civil">Génie Civil</option>
              <option value="Génie Mécanique">Génie Mécanique</option>
              <option value="Commerce et Gestion">Commerce et Gestion</option>
              <option value="Techniques de Management">Techniques de Management</option>
            </select>
          </div>
          <div class="form-group">
            <label class="form-label"><c:choose><c:when test="${lang=='en'}">Year</c:when><c:otherwise>Niveau</c:otherwise></c:choose></label>
            <select name="niveau" class="form-control form-select" required>
              <option value=""><c:choose><c:when test="${lang=='en'}">-- Choose --</c:when><c:otherwise>-- Choisir --</c:otherwise></c:choose></option>
              <option value="1ère année"><c:choose><c:when test="${lang=='en'}">1st year</c:when><c:otherwise>1ère année</c:otherwise></c:choose></option>
              <option value="2ème année"><c:choose><c:when test="${lang=='en'}">2nd year</c:when><c:otherwise>2ème année</c:otherwise></c:choose></option>
              <option value="3ème année"><c:choose><c:when test="${lang=='en'}">3rd year</c:when><c:otherwise>3ème année</c:otherwise></c:choose></option>
            </select>
          </div>
        </div>
        <div style="height:1px;background:#dce3ef;margin:16px 0;"></div>
        <div class="form-group">
          <label class="form-label"><c:choose><c:when test="${lang=='en'}">Username</c:when><c:otherwise>Nom d'utilisateur</c:otherwise></c:choose></label>
          <input type="text" name="username" class="form-control" required minlength="3">
        </div>
        <div class="form-group">
          <label class="form-label"><c:choose><c:when test="${lang=='en'}">Email</c:when><c:otherwise>Email</c:otherwise></c:choose></label>
          <input type="email" name="email" class="form-control" required>
        </div>
        <div class="form-group">
          <label class="form-label"><c:choose><c:when test="${lang=='en'}">Password</c:when><c:otherwise>Mot de passe</c:otherwise></c:choose></label>
          <input type="password" name="password" class="form-control" required minlength="4">
        </div>
        <button type="submit" class="btn btn-accent btn-lg" style="width:100%;justify-content:center;margin-top:8px;">
          <c:choose><c:when test="${lang=='en'}">Create my account</c:when><c:otherwise>Créer mon compte</c:otherwise></c:choose>
        </button>
      </form>
      <div style="text-align:center;margin-top:16px;color:#6b7280;font-size:.88rem;">
        <c:choose><c:when test="${lang=='en'}">Already registered?</c:when><c:otherwise>Déjà inscrit ?</c:otherwise></c:choose>
        <a href="${pageContext.request.contextPath}/login" style="color:#1b4f8a;font-weight:600;">
          <c:choose><c:when test="${lang=='en'}">Login</c:when><c:otherwise>Se connecter</c:otherwise></c:choose>
        </a>
      </div>
      <div style="text-align:center;margin-top:12px;">
        <a href="${pageContext.request.contextPath}/language?lang=fr" style="color:#94a3b8;font-size:.8rem;margin-right:8px;">🇫🇷 Français</a>
        <a href="${pageContext.request.contextPath}/language?lang=en" style="color:#94a3b8;font-size:.8rem;">🇬🇧 English</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>
