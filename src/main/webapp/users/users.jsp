<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facebook CRUD - Lista de Usuários</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/user.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>

    <nav class="navbar navbar-custom mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/">
                Facebook Web Crud
            </a>
            <a class="btn btn-light btn-sm border" href="${pageContext.request.contextPath}/">
                <i class="bi bi-house-door-fill"></i> Home
            </a>
        </div>
    </nav>

    <main class="container">
        <div class="row align-items-center mb-4">
            <div class="col">
                <h2 class="fw-bold m-0">Usuários Cadastrados</h2>
                <p class="text-muted small">Total de perfis ativos no sistema</p>
            </div>
            <div class="col-auto">
                <a href="${pageContext.request.contextPath}/users/form_user.jsp" class="btn btn-add-user text-white px-4">
                    <i class="bi bi-person-plus-fill me-2"></i>Novo Usuário
                </a>
            </div>
        </div>

        <div class="main-card shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th class="text-center" style="width: 80px;">ID</th>
                            <th>Nome do Usuário</th>
                            <th class="text-center">Gênero</th>
                            <th>Email Institucional</th>
                            <th class="text-center">Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="usuario" items="${usuarios}">
                            <tr>
                                <td class="text-center text-muted fw-bold small">${usuario.getId()}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="user-avatar">
                                            <i class="bi bi-person"></i>
                                        </div>
                                        <span class="fw-semibold text-dark">${usuario.getName()}</span>
                                    </div>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test='${usuario.getGender().equals("M")}'>
                                            <span class="gender-badge gender-m text-uppercase">Masc</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="gender-badge gender-f text-uppercase">Fem</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-muted">${usuario.getEmail()}</td>
                                <td class="text-center">
                                    <div class="d-flex justify-content-center gap-2">
                                        <a title="Editar" class="btn-action btn-edit" 
                                           href="${pageContext.request.contextPath}/users/update?userId=${usuario.getId()}">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a title="Excluir" class="btn-action btn-delete"
                                           href="${pageContext.request.contextPath}/users/delete?userId=${usuario.getId()}"
                                           onclick="return confirm('Excluir usuário permanentemente?')">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            
            <c:if test="${empty usuarios}">
                <div class="text-center py-5">
                    <i class="bi bi-people text-light-emphasis fs-1"></i>
                    <p class="text-muted mt-2">Nenhum usuário cadastrado até o momento.</p>
                </div>
            </c:if>
        </div>

       <footer class="text-center mt-5 pb-4 text-muted small">
            &copy; 2026 FacebookWebCRUD
        </footer>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>