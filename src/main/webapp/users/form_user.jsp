<jsp:directive.page contentType="text/html; charset=UTF-8" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-icons.css">
<title>Cadastro de Usuário</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-6">
				<form action="${pageContext.request.contextPath}/users/save" method="GET">
					<h1>${usuario eq null ? "Cadastro" : "Atualização"} de Usuário</h1>
					<div class="mb-3">
						<label for="user_name_id" class="form-label">Nome do Usuário:</label>
						<input class="form-control" type="text" id="user_name_id" name="user_name" placeholder="Nome" value="${usuario.getName()}">
					</div>
						
					<div class="mb-3">
						<label class="form-label">Gênero:</label>
						<div class="form-check">
							<input class="form-check-input" type="radio" id="user_gender_m" name="user_gender" value="M" ${usuario.getGender().equals("M") ? "checked" : ""}>
							<label for="user_gender_m" class="form-check-label">Masculino</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" id="user_gender_f" name="user_gender" value="F" ${usuario.getGender().equals("F") ? "checked" : ""}>
							<label for="user_gender_f" class="form-check-label">Feminino</label>
						</div>
					</div>
					
					<div class="mb-3">
						<label for="user_email_id" class="form-label">Email:</label>
						<input class="form-control" type="text" id="user_email_id" name="user_email" placeholder="Email" value="${usuario.getEmail()}">
					</div>
					
					<button type="submit" class="btn btn-primary">${usuario eq null ? "Cadastrar" : "Atualizar"}</button>
				</form>
			</div>
			<div class="col-md-1"></div>
		</div>
	</div>
</body>
</html>