package servlets;
import beans.User;
import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (req.getSession(false) == null || req.getSession().getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath()+"/login"); return;
        }
        req.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(req, res);
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (User) session.getAttribute("user");
        String action = req.getParameter("action");
        UserDAO dao = new UserDAO();

        if ("updateProfile".equals(action)) {
            currentUser.setUsername(req.getParameter("username").trim());
            currentUser.setEmail(req.getParameter("email").trim());
            currentUser.setNom(req.getParameter("nom"));
            currentUser.setPrenom(req.getParameter("prenom"));
            currentUser.setFiliere(req.getParameter("filiere"));
            currentUser.setNiveau(req.getParameter("niveau"));
            currentUser.setCne(req.getParameter("cne"));
            currentUser.setBio(req.getParameter("bio"));
            if (dao.updateProfile(currentUser)) {
                session.setAttribute("user", currentUser);
                req.setAttribute("message", "Profil mis à jour avec succès !");
            } else req.setAttribute("error", "Erreur lors de la mise à jour.");
        } else if ("changePassword".equals(action)) {
            String old = req.getParameter("oldPassword");
            String nw  = req.getParameter("newPassword");
            String cfm = req.getParameter("confirmPassword");
            if (!old.equals(currentUser.getPassword())) req.setAttribute("error", "Ancien mot de passe incorrect !");
            else if (!nw.equals(cfm)) req.setAttribute("error", "Les mots de passe ne correspondent pas !");
            else { dao.updatePassword(currentUser.getId(), nw); currentUser.setPassword(nw); session.setAttribute("user", currentUser); req.setAttribute("message", "Mot de passe modifié !"); }
        }
        req.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(req, res);
    }
}
