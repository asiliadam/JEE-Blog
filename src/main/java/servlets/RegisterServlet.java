package servlets;
import beans.User;
import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(req, res);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String username = req.getParameter("username").trim();
        String email    = req.getParameter("email").trim();
        String password = req.getParameter("password");
        String nom      = req.getParameter("nom").trim();
        String prenom   = req.getParameter("prenom").trim();
        String filiere  = req.getParameter("filiere").trim();
        String niveau   = req.getParameter("niveau");
        String cne      = req.getParameter("cne").trim();

        UserDAO dao = new UserDAO();
        if (dao.emailExists(email)) {
            req.setAttribute("error", "Cet email est déjà utilisé !");
            req.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(req, res); return;
        }
        if (dao.usernameExists(username)) {
            req.setAttribute("error", "Ce nom d'utilisateur est déjà pris !");
            req.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(req, res); return;
        }
        User user = new User(username, email, password);
        user.setNom(nom); user.setPrenom(prenom);
        user.setFiliere(filiere); user.setNiveau(niveau); user.setCne(cne);
        user.setVerificationToken(UUID.randomUUID().toString());

        if (dao.register(user)) {
            req.setAttribute("message", "Inscription réussie ! Vous pouvez vous connecter.");
        } else {
            req.setAttribute("error", "Erreur lors de l'inscription. Réessayez.");
        }
        req.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(req, res);
    }
}
