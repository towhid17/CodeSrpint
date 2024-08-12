package net.therap.filter;

import net.therap.model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static java.util.Objects.nonNull;

/**
 * @author towhidul.islam
 * @since 10/11/23
 */
public class LoggedOutCheckFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws ServletException, IOException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        User user = (User) req.getSession().getAttribute("SESSION_USER");

        if (nonNull(user)) {
            res.sendRedirect(req.getContextPath() + "/problem/list");

        } else {
            chain.doFilter(request, response);
        }
    }

}
