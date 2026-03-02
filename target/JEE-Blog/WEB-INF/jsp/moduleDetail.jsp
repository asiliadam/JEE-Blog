<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
  <title>${module.titre} — EduForum</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="detail-header">
  <div class="container">
    <div class="breadcrumb">
      <a href="${pageContext.request.contextPath}/modules">Modules</a>
      <span class="sep">›</span>
      <span>${module.titre}</span>
    </div>
    <h1>${module.titre}</h1>
    <div class="detail-meta">
      <span>👤 ${module.authorName}</span>
      <span>📅 <fmt:formatDate value="${module.createdAt}" pattern="dd/MM/yyyy"/></span>
      <span>❓ ${questions.size()} question${questions.size() > 1 ? 's' : ''}</span>
    </div>
    <div class="detail-tags">
      <c:if test="${not empty module.filiere}"><span class="tag tag-filiere">${module.filiere}</span></c:if>
      <c:if test="${not empty module.niveau}"><span class="tag tag-niveau">${module.niveau}</span></c:if>
      <c:if test="${not empty module.semestre}"><span class="tag tag-semestre">Semestre ${module.semestre}</span></c:if>
    </div>
    <c:if test="${sessionScope.user.admin}">
      <div style="margin-top:16px;display:flex;gap:10px;">
        <a href="${pageContext.request.contextPath}/modules?action=edit&id=${module.id}" class="btn btn-outline btn-sm" style="color:#e2e8f0;border-color:#475569;">✏️ Modifier</a>
        <a href="${pageContext.request.contextPath}/modules?action=delete&id=${module.id}" class="btn btn-danger btn-sm"
           onclick="return confirm('Supprimer ce module ?')">🗑️ Supprimer</a>
      </div>
    </c:if>
  </div>
</div>

<div class="container main-content">
  <div style="display:grid;grid-template-columns:1fr 380px;gap:28px;">
    <div>
      <%-- Description --%>
      <div class="content-card">
        <h2>Description du module</h2>
        <p class="prose">${module.description}</p>
      </div>
      <%-- Contenu --%>
      <c:if test="${not empty module.contenu}">
        <div class="content-card">
          <h2>Contenu du cours</h2>
          <p class="prose">${module.contenu}</p>
        </div>
      </c:if>

      <%-- Questions --%>
      <div class="section-title">Questions des étudiants</div>
      <c:choose>
        <c:when test="${empty questions}">
          <div class="empty-state" style="padding:40px;">
            <div class="empty-icon">💬</div>
            <h3>Aucune question</h3>
            <p>Soyez le premier à poser une question !</p>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach var="q" items="${questions}">
            <div class="question-card">
              <div class="question-header">
                <div class="question-author">
                  <div class="q-avatar">${q.authorName.substring(0,1)}</div>
                  <div class="author-info">
                    <div class="name">${q.authorName}</div>
                    <div class="meta">
                      <c:if test="${not empty q.authorFiliere}">${q.authorFiliere} — </c:if>
                      <fmt:formatDate value="${q.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                    </div>
                  </div>
                </div>
                <div style="display:flex;align-items:center;gap:8px;">
                  <span class="stat" style="font-size:.78rem;color:#6b7280;">↩ ${q.reponseCount}</span>
                  <c:if test="${sessionScope.user.id == q.userId || sessionScope.user.admin}">
                    <form method="post" action="${pageContext.request.contextPath}/questions" style="display:inline;">
                      <input type="hidden" name="action" value="delete">
                      <input type="hidden" name="id" value="${q.id}">
                      <input type="hidden" name="moduleId" value="${module.id}">
                      <button class="btn btn-danger btn-sm" onclick="return confirm('Supprimer ?')">🗑️</button>
                    </form>
                  </c:if>
                </div>
              </div>
              <div class="question-body"><p>${q.contenu}</p></div>

              <%-- Réponses --%>
              <c:set var="reps" value="${reponseMap[q.id]}"/>
              <c:if test="${not empty reps}">
                <div class="reponse-list">
                  <c:forEach var="r" items="${reps}">
                    <div class="reponse-item ${sessionScope.user.admin ? 'admin-rep' : ''}">
                      <div class="reponse-author">
                        ↩
                        <c:choose>
                          <c:when test="${r.authorName == module.authorName}">
                            <span class="is-prof">Prof. ${r.authorName}</span>
                          </c:when>
                          <c:otherwise>${r.authorName}</c:otherwise>
                        </c:choose>
                        — <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                        <c:if test="${sessionScope.user.id == r.userId || sessionScope.user.admin}">
                          <form method="post" action="${pageContext.request.contextPath}/questions" style="display:inline;margin-left:8px;">
                            <input type="hidden" name="action" value="deleteReponse">
                            <input type="hidden" name="id" value="${r.id}">
                            <input type="hidden" name="moduleId" value="${module.id}">
                            <button class="btn btn-danger btn-sm" style="padding:1px 7px;font-size:.7rem;">×</button>
                          </form>
                        </c:if>
                      </div>
                      <div class="reponse-text">${r.contenu}</div>
                    </div>
                  </c:forEach>
                </div>
              </c:if>

              <%-- Répondre --%>
              <c:if test="${not empty sessionScope.user}">
                <div class="reply-form">
                  <form method="post" action="${pageContext.request.contextPath}/questions">
                    <input type="hidden" name="action" value="repondre">
                    <input type="hidden" name="questionId" value="${q.id}">
                    <input type="hidden" name="moduleId" value="${module.id}">
                    <textarea name="contenu" placeholder="Votre réponse..." required></textarea>
                    <button type="submit" class="btn btn-primary btn-sm">Répondre</button>
                  </form>
                </div>
              </c:if>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>

    <%-- Sidebar: poser une question --%>
    <div>
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <div class="ask-card">
            <div class="section-title" style="font-size:1rem;">Poser une question</div>
            <form method="post" action="${pageContext.request.contextPath}/questions">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="moduleId" value="${module.id}">
              <textarea name="contenu" placeholder="Votre question sur ce module..." required></textarea>
              <button type="submit" class="btn btn-accent" style="width:100%;justify-content:center;">
                Envoyer la question
              </button>
            </form>
          </div>
        </c:when>
        <c:otherwise>
          <div class="ask-card" style="text-align:center;">
            <p style="color:#6b7280;margin-bottom:16px;">Connectez-vous pour poser une question</p>
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary" style="width:100%;justify-content:center;">Se connecter</a>
          </div>
        </c:otherwise>
      </c:choose>

      <div class="info-card" style="margin-top:20px;">
        <h3>Infos module</h3>
        <c:if test="${not empty module.filiere}">
          <div class="info-row"><span class="info-label">Filière</span><span class="info-value">${module.filiere}</span></div>
        </c:if>
        <c:if test="${not empty module.niveau}">
          <div class="info-row"><span class="info-label">Niveau</span><span class="info-value">${module.niveau}</span></div>
        </c:if>
        <c:if test="${not empty module.semestre}">
          <div class="info-row"><span class="info-label">Semestre</span><span class="info-value">${module.semestre}</span></div>
        </c:if>
        <div class="info-row"><span class="info-label">Professeur</span><span class="info-value">${module.authorName}</span></div>
      </div>
    </div>
  </div>
</div>

<footer style="text-align:center;padding:24px;color:#94a3b8;font-size:.8rem;border-top:1px solid #dce3ef;margin-top:40px;">
  © 2026 EduForum — École Supérieure de Technologie, Agadir
</footer>
</body>
</html>
