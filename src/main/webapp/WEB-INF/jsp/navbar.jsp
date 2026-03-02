<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="lang" value="${empty sessionScope.lang ? 'fr' : sessionScope.lang}"/>
<nav class="main-nav">
  <div class="nav-container">
    <a class="nav-brand" href="${pageContext.request.contextPath}/modules">
      <span class="brand-icon">⬡</span>
      <span class="brand-text">EduForum <span class="brand-est">EST Agadir</span></span>
    </a>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/modules" class="nav-link">
        <c:choose><c:when test="${lang=='en'}">Modules</c:when><c:otherwise>Modules</c:otherwise></c:choose>
      </a>
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <a href="${pageContext.request.contextPath}/profile" class="nav-link nav-user">
            <span class="nav-avatar">${not empty sessionScope.user.prenom ? sessionScope.user.prenom.substring(0,1) : sessionScope.user.username.substring(0,1)}</span>
            ${not empty sessionScope.user.prenom ? sessionScope.user.prenom : sessionScope.user.username}
            <c:if test="${sessionScope.user.admin}"><span class="badge-admin"><c:choose><c:when test="${lang=='en'}">Prof</c:when><c:otherwise>Prof</c:otherwise></c:choose></span></c:if>
          </a>
          <a href="${pageContext.request.contextPath}/logout" class="btn-nav-logout">
            <c:choose><c:when test="${lang=='en'}">Logout</c:when><c:otherwise>Déconnexion</c:otherwise></c:choose>
          </a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/login" class="nav-link">
            <c:choose><c:when test="${lang=='en'}">Login</c:when><c:otherwise>Connexion</c:otherwise></c:choose>
          </a>
          <a href="${pageContext.request.contextPath}/register" class="btn-nav-primary">
            <c:choose><c:when test="${lang=='en'}">Register</c:when><c:otherwise>S'inscrire</c:otherwise></c:choose>
          </a>
        </c:otherwise>
      </c:choose>
      <div class="nav-lang">
        <a href="${pageContext.request.contextPath}/language?lang=fr" style="${lang=='fr' ? 'color:white;font-weight:700;' : ''}">FR</a>
        <span>|</span>
        <a href="${pageContext.request.contextPath}/language?lang=en" style="${lang=='en' ? 'color:white;font-weight:700;' : ''}">EN</a>
      </div>
    </div>
  </div>
</nav>
