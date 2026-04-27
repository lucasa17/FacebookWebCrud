<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Facebook CRUD - ${usuario eq null ? "Cadastro" : "Edição"} de Usuário</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/formUser.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>

<div class="container register-container">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-5">
            
            <div class="mb-3 text-start">
                <a class="btn btn-link text-decoration-none text-muted p-0" 
                   href="${pageContext.request.contextPath}/users">
                    <i class="bi bi-arrow-left-circle me-1"></i> Lista de Usuários
                </a>
            </div>

            <div class="card card-user shadow">
                <div class="card-body p-4 p-md-5">
                    <div class="text-center mb-4">
                        <h2 class="fw-bold mb-1">
                            ${usuario eq null ? "Criar conta" : "Editar perfil"}
                        </h2>
                        <p class="text-muted small">É rápido e fácil.</p>
                    </div>
                    
                    <hr class="mb-4 opacity-25">

                    <form action="${pageContext.request.contextPath}/users/save" method="GET">
                        <input type="hidden" name="user_id" value="${usuario.getId()}"> 
                        
                        <div class="mb-3">
                            <label for="user_name_id" class="form-label">Nome Completo</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person"></i></span>
                                <input type="text" id="user_name_id" name="user_name" 
                                       class="form-control border-start-0" 
                                       placeholder="Como você se chama?" 
                                       value="${usuario.getName()}" required>
                            </div>
                        </div>

						<div class="mb-3">
						    <label class="form-label">Gênero</label>
						    <div class="row g-2"> <div class="col">
						            <div class="gender-option shadow-sm border rounded p-2 d-flex justify-content-between align-items-center bg-light">
						                <label class="form-check-label w-100 mb-0 py-1" for="user_gender_m" style="cursor: pointer;">
						                    Masculino
						                </label>
						                <input class="form-check-input mt-0" type="radio" name="user_gender" id="user_gender_m" value="M" 
						                       ${usuario.getGender().equals("M") ? "checked" : ""}>
						            </div>
						        </div>
						        <div class="col">
						            <div class="gender-option shadow-sm border rounded p-2 d-flex justify-content-between align-items-center bg-light">
						                <label class="form-check-label w-100 mb-0 py-1" for="user_gender_f" style="cursor: pointer;">
						                    Feminino
						                </label>
						                <input class="form-check-input mt-0" type="radio" name="user_gender" id="user_gender_f" value="F" 
						                       ${usuario.getGender().equals("F") ? "checked" : ""}>
						            </div>
						        </div>
						    </div>
						</div>

                        <div class="mb-3">
                            <label for="user_email_id" class="form-label">E-mail</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope"></i></span>
                                <input type="email" id="user_email_id" name="user_email" 
                                       class="form-control border-start-0" 
                                       placeholder="email@exemplo.com" 
                                       value="${usuario.getEmail()}" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="user_pw_id" class="form-label">Senha</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock"></i></span>
                                <input type="password" id="user_pw_id" name="user_pw" 
                                       class="form-control border-start-0" 
                                       placeholder="Nova senha">
                            </div>
                            <c:if test="${usuario ne null}">
                                <div class="form-text">Deixe em branco para manter a senha atual.</div>
                            </c:if>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-register shadow-sm">
                                ${usuario eq null ? "Cadastrar agora" : "Salvar Alterações"}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>