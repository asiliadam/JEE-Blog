package servlets;
import beans.Question;
import beans.Reponse;
import beans.User;
import dao.QuestionDAO;
import dao.ReponseDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/questions")
public class QuestionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action    = req.getParameter("action");
        String moduleId  = req.getParameter("moduleId");

        // Sécurité: moduleId ne doit pas être null
        if (moduleId == null || moduleId.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/modules");
            return;
        }

        if ("add".equals(action)) {
            String contenu = req.getParameter("contenu");
            if (contenu != null && !contenu.trim().isEmpty()) {
                Question q = new Question();
                q.setContenu(contenu.trim());
                q.setUserId(user.getId());
                q.setModuleId(Integer.parseInt(moduleId));
                new QuestionDAO().add(q);
            }

        } else if ("delete".equals(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Question q = new QuestionDAO().getById(Integer.parseInt(idStr));
                if (q != null && (q.getUserId() == user.getId() || user.isAdmin()))
                    new QuestionDAO().delete(q.getId());
            }

        } else if ("repondre".equals(action)) {
            String contenu    = req.getParameter("contenu");
            String questionId = req.getParameter("questionId");
            if (contenu != null && !contenu.trim().isEmpty() && questionId != null) {
                Reponse r = new Reponse();
                r.setContenu(contenu.trim());
                r.setUserId(user.getId());
                r.setQuestionId(Integer.parseInt(questionId));
                new ReponseDAO().add(r);
            }

        } else if ("deleteReponse".equals(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null) new ReponseDAO().delete(Integer.parseInt(idStr));
        }

        res.sendRedirect(req.getContextPath() + "/modules?action=view&id=" + moduleId);
    }
}
