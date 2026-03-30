package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelException;
import model.User;
import model.dao.DAOFactory;
import model.dao.UserDAO;
import model.utils.PasswordEncryptor;

@WebServlet(urlPatterns = {"/users" , "/users/save" , "/users/update", "/users/delete"})
public class UsersControler extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
		String action = req.getRequestURI();
		System.out.println(action);
		
		switch(action) {
		case "/facebook/users": {
			loadUsers(req);
			
			// Redirecionamento para a pagina de tratamento (index)
			RequestDispatcher rd = req.getRequestDispatcher("/users/users.jsp");
			rd.forward(req, resp);
			break;
		}
		case"/facebook/users/save": {
			String userIdStr = req.getParameter("user_id");
			if(userIdStr == null || userIdStr == "") {
				insertUser(req);
			}
			else {
				int userId = Integer.parseInt(userIdStr);
				updateUser(req, userId);
			}
			resp.sendRedirect("/facebook/users");
			break;
		}
		case"/facebook/users/update": {			
			loadUser(req);
			
			RequestDispatcher rd = req.getRequestDispatcher("/users/form_user.jsp");
			rd.forward(req, resp);
			break;
		}
		case"/facebook/users/delete": {
			deleteUser(req);
			
			resp.sendRedirect("/facebook/users");
			break;
		}
		default:
			throw new IllegalArgumentException("Unexpeced value: "+ action);
		}
	}
	
	private void deleteUser(HttpServletRequest req) {
		String userIdStr = req.getParameter("userId");
		int userId = Integer.parseInt(userIdStr);
		
		User user = new User(userId);
		
		UserDAO userDAO = DAOFactory.createDAO(UserDAO.class);
		
		try {
			userDAO.delete(user);
		}catch (ModelException e) {
			e.printStackTrace();
		}
	}
	
	private void loadUser(HttpServletRequest req) {
		String userIdStr = req.getParameter("userId");
		int userId = Integer.parseInt(userIdStr);
		
		UserDAO userDAO = DAOFactory.createDAO(UserDAO.class);
		User userToBeUpdated = null;
		try {
			userToBeUpdated = userDAO.findById(userId);
		} catch (ModelException e) {
			e.printStackTrace();
		}
		
		req.setAttribute("usuario", userToBeUpdated);
	}
	
	private void updateUser(HttpServletRequest req, int userId) {
		User user = fillUser(req, userId);
		
		UserDAO userDAO = DAOFactory.createDAO(UserDAO.class);
		try {
			userDAO.update(user);
		}catch(ModelException e) {
			e.printStackTrace();
		}
	}
	
	private void insertUser(HttpServletRequest req) {
		User user = fillUser(req, null);
		
		UserDAO userDAO = DAOFactory.createDAO(UserDAO.class);
		try {
			userDAO.save(user);
		}catch(ModelException e) {
			e.printStackTrace();
		}
		
	}
	
	private void loadUsers(HttpServletRequest req) {
		UserDAO userDAO = DAOFactory.createDAO(UserDAO.class);
		
		List<User> users = List.of();
		
		try {
			users = userDAO.listAll();
		} catch (Exception e ) {
			e.printStackTrace(); // só loga no servidor
		}
		
		// Adciona a lista de usuários na requisição original
		req.setAttribute("usuarios", users);
	}
	
	private User fillUser(HttpServletRequest req, Integer userId) {
		String userName = req.getParameter("user_name");
		String userGender = req.getParameter("user_gender");
		String userEmail = req.getParameter("user_email");
		String userPw = req.getParameter("user_pw");
		
		User user;
		if(userId == null) {
			user = new User();
		}
		else {
			user = new User(userId);
		}
		
		user.setName(userName);
		user.setGender(userGender);
		user.setEmail(userEmail);
		String userPWHash = PasswordEncryptor.hashPassword(userPw);
		user.setPassword(userPWHash);
		
		return user;
	}
}
