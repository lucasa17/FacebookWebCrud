<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facebook CRUD - ${post != null && post.id != 0 ? "Editar Post" : "Novo Post"}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/formPost.css"/>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="col-12 col-md-8 col-lg-6">
        
        <div class="card card-post p-4">
            <div class="card-body">
                <h2 class="header-title mb-4">
                    ${post != null && post.id != 0 ? "Atualizar Post" : "Nova Publicação"}
                </h2>
                
                <hr class="mb-4 opacity-25">

                <form action="/facebook/posts/save" method="post">
                    <input type="hidden" name="post_id" value="${post.id}">
                    
                    <div class="mb-4">
                        <label class="form-label text-uppercase small">Quem está postando?</label>
                        <select name="user_id" class="form-select shadow-sm" required>
                            <option value="">Selecione o perfil...</option>
                            <c:forEach var="u" items="${usuarios}">
                                <option value="${u.id}" ${post.user.id == u.id ? 'selected' : ''}>
                                    ${u.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label text-uppercase small">O que você está pensando?</label>
                        <textarea name="content" class="form-control shadow-sm" 
                                  placeholder="Escreva algo interessante..." 
                                  rows="5" required style="resize: none;">${post.content}</textarea>
                    </div>
                    
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end pt-2">
                        <a href="/facebook/posts" class="btn btn-light px-4 border">Cancelar</a>
                        <button type="submit" class="btn btn-facebook text-white px-5">
                            ${post != null && post.id != 0 ? "Salvar Alterações" : "Publicar"}
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <p class="text-center mt-4 text-muted small">Facebook Web Crud &copy; 2026</p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>