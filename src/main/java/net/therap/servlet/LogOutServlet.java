package net.therap.servlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static net.therap.helper.AuthenticationHelper.removeSessionUser;

/**
 * @author towhidul.islam
 * @since 10/1/23
 */
public class LogOutServlet extends HttpServlet {

    public LogOutServlet() {
        super();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        removeSessionUser(request);

        request.getSession().invalidate();

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        response.sendRedirect(request.getContextPath() + "/login");
    }

}