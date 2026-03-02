<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="lang" value="${empty sessionScope.lang ? 'fr' : sessionScope.lang}"/>
<!DOCTYPE html>
<html lang="${lang}">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Modules — EduForum EST Agadir</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="page-header">
  <div class="header-inner">
    <div>
      <c:choose>
        <c:when test="${lang == 'en'}">
          <h1>Learning Modules</h1>
          <p>Browse modules and ask your questions</p>
        </c:when>
        <c:otherwise>
          <h1>Modules Pédagogiques</h1>
          <p>Consultez les modules et posez vos questions</p>
        </c:otherwise>
      </c:choose>
    </div>
    <c:if test="${sessionScope.user.admin}">
      <a href="${pageContext.request.contextPath}/modules?action=new" class="btn btn-accent">
        + <c:choose><c:when test="${lang == 'en'}">New Module</c:when><c:otherwise>Nouveau Module</c:otherwise></c:choose>
      </a>
    </c:if>
  </div>
</div>

<div class="container main-content">
  <c:choose>
    <c:when test="${empty modules}">
      <div class="empty-state">
        <div class="empty-icon">📚</div>
        <c:choose>
          <c:when test="${lang == 'en'}">
            <h3>No modules available</h3>
            <p>Modules will be added by professors.</p>
          </c:when>
          <c:otherwise>
            <h3>Aucun module disponible</h3>
            <p>Les modules seront ajoutés par les professeurs.</p>
          </c:otherwise>
        </c:choose>
      </div>
    </c:when>
    <c:otherwise>
      <div class="modules-grid">
        <c:forEach var="m" items="${modules}">
          <div class="module-card">
            <div class="module-card-header">
              <h3>${m.titre}</h3>
              <div class="module-meta">
                <c:if test="${not empty m.filiere}"><span class="tag tag-filiere">${m.filiere}</span></c:if>
                <c:if test="${not empty m.niveau}"><span class="tag tag-niveau">${m.niveau}</span></c:if>
                <c:if test="${not empty m.semestre}"><span class="tag tag-semestre">S${m.semestre}</span></c:if>
              </div>
            </div>
            <div class="module-card-body">
              <p>${m.excerpt}</p>
            </div>
            <div class="module-card-footer">
              <div class="module-stats">
                <span class="stat">👤 ${m.authorName}</span>
                <span class="stat">❓ ${m.questionCount}</span>
              </div>
              <div class="module-actions">
                <a href="${pageContext.request.contextPath}/modules?action=view&id=${m.id}" class="btn btn-primary btn-sm">
                  <c:choose><c:when test="${lang == 'en'}">View</c:when><c:otherwise>Voir</c:otherwise></c:choose>
                </a>
                <c:if test="${sessionScope.user.admin}">
                  <a href="${pageContext.request.contextPath}/modules?action=edit&id=${m.id}" class="btn btn-outline btn-sm">✏️</a>
                  <a href="${pageContext.request.contextPath}/modules?action=delete&id=${m.id}"
                     class="btn btn-danger btn-sm"
                     onclick="return confirm('Supprimer ?')">🗑️</a>
                </c:if>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>
</div>

<footer style="text-align:center;padding:24px;color:#94a3b8;font-size:.8rem;border-top:1px solid #dce3ef;margin-top:40px;">
  © 2026 EduForum — École Supérieure de Technologie, Agadir
</footer>
</body>
</html>
