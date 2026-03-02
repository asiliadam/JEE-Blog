package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Locale;

@WebServlet("/language")
public class LanguageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String lang = req.getParameter("lang");
        HttpSession session = req.getSession();

        if ("en".equals(lang)) {
            session.setAttribute("locale", Locale.ENGLISH);
            session.setAttribute("lang", "en");
        } else {
            session.setAttribute("locale", Locale.FRENCH);
            session.setAttribute("lang", "fr");
        }

        String referer = req.getHeader("Referer");
        res.sendRedirect(referer != null ? referer : req.getContextPath() + "/articles");
    }
}
