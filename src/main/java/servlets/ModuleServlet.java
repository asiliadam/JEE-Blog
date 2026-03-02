package servlets;
import beans.Module;
import beans.Question;
import beans.Reponse;
import beans.User;
import dao.ModuleDAO;
import dao.QuestionDAO;
import dao.ReponseDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/modules")
public class ModuleServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        ModuleDAO dao = new ModuleDAO();

        if (action == null || action.equals("list")) {
            req.setAttribute("modules", dao.getAll());
            req.getRequestDispatcher("/WEB-INF/jsp/modules.jsp").forward(req, res);

        } else if (action.equals("view")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Module module = dao.getById(id);
            if (module == null) { res.sendRedirect(req.getContextPath()+"/modules"); return; }

            List<Question> questions = new QuestionDAO().getByModule(id);
            // Load reponses for each question
            ReponseDAO rDao = new ReponseDAO();
            Map<Integer, List<Reponse>> reponseMap = new HashMap<>();
            for (Question q : questions) {
                reponseMap.put(q.getId(), rDao.getByQuestion(q.getId()));
            }
            req.setAttribute("module", module);
            req.setAttribute("questions", questions);
            req.setAttribute("reponseMap", reponseMap);
            req.getRequestDispatcher("/WEB-INF/jsp/moduleDetail.jsp").forward(req, res);

        } else if (action.equals("new")) {
            if (!isAdmin(req)) { res.sendRedirect(req.getContextPath()+"/modules"); return; }
            req.getRequestDispatcher("/WEB-INF/jsp/newModule.jsp").forward(req, res);

        } else if (action.equals("edit")) {
            if (!isAdmin(req)) { res.sendRedirect(req.getContextPath()+"/modules"); return; }
            Module module = dao.getById(Integer.parseInt(req.getParameter("id")));
            req.setAttribute("module", module);
            req.getRequestDispatcher("/WEB-INF/jsp/editModule.jsp").forward(req, res);

        } else if (action.equals("delete")) {
            if (!isAdmin(req)) { res.sendRedirect(req.getContextPath()+"/modules"); return; }
            dao.delete(Integer.parseInt(req.getParameter("id")));
            res.sendRedirect(req.getContextPath()+"/modules");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) { res.sendRedirect(req.getContextPath()+"/login"); return; }
        User user = (User) session.getAttribute("user");
        if (!user.isAdmin()) { res.sendRedirect(req.getContextPath()+"/modules"); return; }

        String action = req.getParameter("action");
        ModuleDAO dao = new ModuleDAO();

        Module m = new Module();
        m.setTitre(req.getParameter("titre").trim());
        m.setDescription(req.getParameter("description").trim());
        String contenu = req.getParameter("contenu"); m.setContenu(contenu != null ? contenu.trim() : "");
        String filiere = req.getParameter("filiere"); m.setFiliere(filiere != null ? filiere : "");
        String niveau  = req.getParameter("niveau");  m.setNiveau(niveau != null ? niveau : "");
        String semestre= req.getParameter("semestre");m.setSemestre(semestre != null ? semestre : "");

        if ("create".equals(action)) {
            m.setUserId(user.getId());
            dao.create(m);
            res.sendRedirect(req.getContextPath()+"/modules");
        } else if ("update".equals(action)) {
            m.setId(Integer.parseInt(req.getParameter("id")));
            dao.update(m);
            res.sendRedirect(req.getContextPath()+"/modules?action=view&id="+m.getId());
        }
    }

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        if (s == null) return false;
        User u = (User) s.getAttribute("user");
        return u != null && u.isAdmin();
    }
}
