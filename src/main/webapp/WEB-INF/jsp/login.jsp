<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="lang" value="${empty sessionScope.lang ? 'fr' : sessionScope.lang}"/>
<!DOCTYPE html>
<html lang="${lang}">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title><c:choose><c:when test="${lang=='en'}">Login</c:when><c:otherwise>Connexion</c:otherwise></c:choose> — EduForum EST Agadir</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-page">
  <div class="auth-card">
    <div class="auth-card-header">
      <div class="logo">⬡</div>
      <h2>EduForum</h2>
      <p><c:choose><c:when test="${lang=='en'}">Academic space — EST Agadir</c:when><c:otherwise>Espace pédagogique — EST Agadir</c:otherwise></c:choose></p>
    </div>
    <div class="auth-card-body">
      <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>
      <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
      <form method="post" action="${pageContext.request.contextPath}/login">
        <div class="form-group">
          <label class="form-label"><c:choose><c:when test="${lang=='en'}">Email Address</c:when><c:otherwise>Adresse Email</c:otherwise></c:choose></label>
          <input type="email" name="email" class="form-control" placeholder="votre@email.com" required>
        </div>
        <div class="form-group">
          <label class="form-label"><c:choose><c:when test="${lang=='en'}">Password</c:when><c:otherwise>Mot de passe</c:otherwise></c:choose></label>
          <input type="password" name="password" class="form-control" placeholder="••••••••" required>
        </div>
        <button type="submit" class="btn btn-primary btn-lg" style="width:100%;justify-content:center;margin-top:8px;">
          <c:choose><c:when test="${lang=='en'}">Login</c:when><c:otherwise>Se connecter</c:otherwise></c:choose>
        </button>
      </form>
      <div style="text-align:center;margin-top:20px;color:#6b7280;font-size:.88rem;">
        <c:choose><c:when test="${lang=='en'}">Not registered yet?</c:when><c:otherwise>Pas encore inscrit ?</c:otherwise></c:choose>
        <a href="${pageContext.request.contextPath}/register" style="color:#1b4f8a;font-weight:600;">
          <c:choose><c:when test="${lang=='en'}">Create account</c:when><c:otherwise>Créer un compte</c:otherwise></c:choose>
        </a>
      </div>
      <div style="text-align:center;margin-top:16px;">
        <a href="${pageContext.request.contextPath}/language?lang=fr" style="color:#94a3b8;font-size:.8rem;margin-right:8px;">🇫🇷 Français</a>
        <a href="${pageContext.request.contextPath}/language?lang=en" style="color:#94a3b8;font-size:.8rem;">🇬🇧 English</a>
      </div>
    </div>
  </div>
</div>
</body>
</html>
