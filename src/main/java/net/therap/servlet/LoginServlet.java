package net.therap.servlet;

import net.therap.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static net.therap.helper.AuthenticationHelper.isValidCredential;
import static net.therap.helper.AuthenticationHelper.setSessionUser;
import static net.therap.service.LoginService.getUserByUserName;

/**
 * @author towhidul.islam
 * @since 9/25/23
 */
public class LoginServlet extends HttpServlet {

    public LoginServlet() {
        super();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/views/login.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        User user = getUserByUserName(userName);

        if (!isValidCredential(user, password)) {
            request.setAttribute("error", "Username or Password incorrect");

            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/views/login.jsp");
            requestDispatcher.forward(request, response);

        } else {
            setSessionUser(request, user);

            response.sendRedirect(request.getContextPath() + "/problem/list");
        }
    }

}