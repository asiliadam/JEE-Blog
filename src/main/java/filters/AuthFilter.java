package filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter({"/profile", "/articles"})
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  httpReq = (HttpServletRequest) req;
        HttpServletResponse httpRes = (HttpServletResponse) res;

        HttpSession session = httpReq.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("user") != null;

        // Pour /articles, on laisse passer (lecture publique), seulement créer/modifier nécessite auth
        String uri = httpReq.getRequestURI();
        String action = httpReq.getParameter("action");

        if (uri.contains("/profile") && !loggedIn) {
            httpRes.sendRedirect(httpReq.getContextPath() + "/login");
            return;
        }

        chain.doFilter(req, res);
    }

    public void init(FilterConfig fc) {}
    public void destroy() {}
}
