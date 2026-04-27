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
import model.Post;
import model.User;
import model.dao.DAOFactory;
import model.dao.PostDAO;
import model.dao.UserDAO;

@WebServlet(urlPatterns = {"/posts", "/posts/save", "/posts/update", "/posts/delete"})
public class PostsController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String action = req.getRequestURI();
		
		switch (action) {
		case "/facebook/posts": {
			loadPosts(req);
			RequestDispatcher rd = req.getRequestDispatcher("/posts/posts.jsp");
			rd.forward(req, resp);
			break;
		}
		case "/facebook/posts/save" : {
			String postIdStr = req.getParameter("post_id");
			
			if (postIdStr == null || postIdStr.equals("") || postIdStr.equals("0")) {
				insertPost(req);
			} else {
				int postId = Integer.parseInt(postIdStr);
				updatePost(req, postId);
			}
			resp.sendRedirect("/facebook/posts");
			break;
		} 
		case "/facebook/posts/update": {
			String postIdStr = req.getParameter("postId");
			
			if (postIdStr != null && !postIdStr.isEmpty()) {
				loadPost(req);
			} else {
				req.setAttribute("post", new Post());
			}
			
			loadUsers(req); // Carrega os usuários para o select
			RequestDispatcher rd = req.getRequestDispatcher("/posts/form_post.jsp");		
			rd.forward(req, resp);
			break;
		} 
		case "/facebook/posts/delete": {	
			deletePost(req);
			resp.sendRedirect("/facebook/posts");
			break;
		} 
		default:
			throw new IllegalArgumentException("Unexpected value: " + action);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		doGet(req, resp);
	}
	
	private void deletePost(HttpServletRequest req) {
		String postIdStr = req.getParameter("postId");
		int postId = Integer.parseInt(postIdStr);
		
		Post post = new Post(postId);
		PostDAO postDAO = DAOFactory.createDAO(PostDAO.class);	
		try {
			postDAO.delete(post);
		} catch (ModelException e) {
			e.printStackTrace();
		}
	}
	
	private void loadPost(HttpServletRequest req) {
		String postIdStr = req.getParameter("postId");
		int postId = Integer.parseInt(postIdStr);
		
		PostDAO postDAO = DAOFactory.createDAO(PostDAO.class);
		Post postToBeUpdated = null;
		try {
			postToBeUpdated = postDAO.findById(postId);
		} catch (ModelException e) {
			e.printStackTrace();
		}
		req.setAttribute("post", postToBeUpdated);	
	}
	
	private void updatePost(HttpServletRequest req, int postId) {
		Post post = fillPost(req, postId);
		PostDAO postDAO = DAOFactory.createDAO(PostDAO.class);	
		try {
			postDAO.update(post);
		} catch (ModelException e) {
			e.printStackTrace();
		}
	}
	
	private void insertPost(HttpServletRequest req) {
		Post post = fillPost(req, null);
		PostDAO postDAO = DAOFactory.createDAO(PostDAO.class);
		try {
			postDAO.save(post);
		} catch (ModelException e) {
			e.printStackTrace();
		}
	}
	
	private void loadPosts(HttpServletRequest req) {
		PostDAO postDAO = DAOFactory.createDAO(PostDAO.class);
		List<Post> posts = List.of();
		try {
			posts = postDAO.listAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		req.setAttribute("posts", posts);
	}

	private void loadUsers(HttpServletRequest req) {
		UserDAO userDAO = DAOFactory.createDAO(UserDAO.class);
		List<User> users = List.of();
		try {
			users = userDAO.listAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		req.setAttribute("usuarios", users);
	}
	
	private Post fillPost(HttpServletRequest req, Integer postId) {
		String content = req.getParameter("content");
		int userId = Integer.parseInt(req.getParameter("user_id"));
		
		// Se o id for nulo ou 0, cria um post novo, senão cria com o id de edição
		Post post = (postId == null || postId == 0) ? new Post() : new Post(postId);
		post.setContent(content);
		post.setUser(new User(userId));
		
		return post;
	}
}