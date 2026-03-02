package servlets;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/verify")
public class VerifyServlet extends HttpServlet {
    // Verification par email non utilisée dans cette version
    // Tous les comptes sont vérifiés automatiquement à l'inscription
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setAttribute("message", "Compte activé ! Vous pouvez vous connecter.");
        req.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(req, res);
    }
}
