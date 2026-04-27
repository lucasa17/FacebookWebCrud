<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facebook CRUD - Lista de Posts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/post.css"/>
</head>
<body>

    <nav class="navbar navbar-custom mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/">
                Facebook Web Crud
            </a>
            <a class="btn btn-outline-secondary btn-sm" href="${pageContext.request.contextPath}/">
                <i class="bi bi-house-fill"></i> Home
            </a>
        </div>
    </nav>

    <main class="container">
        <div class="row align-items-center mb-4">
            <div class="col">
                <h2 class="fw-bold m-0">Lista de Publicações</h2>
                <p class="text-muted small">Gerencie todos os posts da rede</p>
            </div>
            <div class="col-auto">
                <a href="/facebook/posts/update" class="btn btn-add-post shadow-sm px-4">
                    <i class="bi bi-plus-lg me-1"></i> Criar Novo Post
                </a>
            </div>
        </div>

        <div class="table-container">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead>
                        <tr>
                            <th class="text-center">ID</th>
                            <th>Autor</th>
                            <th>Conteúdo</th>
                            <th>Data de Criação</th>
                            <th class="text-end">Gerenciar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${posts}">
                            <tr>
                                <td class="text-center text-muted fw-bold">${p.id}</td>
                                <td>
                                    <span class="author-badge text-decoration-none">
                                        <i class="bi bi-person-circle me-1"></i> ${p.user.name}
                                    </span>
                                </td>
                                <td>
                                    <div class="post-content-preview" title="${p.content}">
                                        ${p.content}
                                    </div>
                                </td>
                                <td class="text-muted small">
                                    <i class="bi bi-calendar3 me-1"></i> ${p.postDate}
                                </td>
                                <td class="text-end">
                                    <div class="btn-group shadow-sm">
                                        <a title="Editar" class="btn btn-edit btn-action" 
                                           href="${pageContext.request.contextPath}/posts/update?postId=${p.id}">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a title="Excluir" class="btn btn-delete btn-action"
                                           href="${pageContext.request.contextPath}/posts/delete?postId=${p.id}"
                                           onclick="return confirm('Deseja realmente excluir este post?')">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty posts}">
                            <tr>
                                <td colspan="5" class="text-center py-5 text-muted">
                                    <i class="bi bi-chat-dots d-block mb-2 fs-1"></i>
                                    Nenhum post encontrado.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <footer class="text-center mt-5 pb-4 text-muted small">
            &copy; 2026 FacebookWebCRUD
        </footer>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>