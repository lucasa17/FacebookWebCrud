import model.ModelException;
import model.Post;
import model.User;
import model.dao.DAOFactory;
import model.dao.PostDAO;
import model.dao.UserDAO;

public class Main {

	public static void main(String[] args) throws ModelException{
		PostDAO postDAO = DAOFactory.createDAO(PostDAO.class);
		
		for(Post post : postDAO.listAll()) {
			System.out.println(post.getContent() + " - " + post.getUser().getName());
		}
	}

}
