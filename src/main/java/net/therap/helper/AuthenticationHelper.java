package net.therap.helper;

import net.therap.model.User;
import net.therap.utils.RoleType;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthorizationHelper.hasRole;

/**
 * @author towhidul.islam
 * @since 9/25/23
 */
public class AuthenticationHelper {

    public static boolean isValidCredential(User user, String inputPassword) {
        if (isNull(user) || user.getLock()) {
            return false;
        }

        return user.getPassword().equals(generateMD5CryptHash(inputPassword));
    }

    public static String generateMD5CryptHash(String password) {
        MessageDigest md;

        try {
            md = MessageDigest.getInstance("SHA-512");

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        byte[] bytes = md.digest(password.getBytes());
        password = new String(bytes);

        return password;
    }

    public static void setSessionUser(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setAttribute("SESSION_USER", user);

        if (hasRole(user, RoleType.ADMIN)) {
            session.setAttribute("SESSION_USER_ROLE", "ADMIN");

        } else if (hasRole(user, RoleType.MODERATOR)) {
            session.setAttribute("SESSION_USER_ROLE", "MODERATOR");

        } else if (hasRole(user, RoleType.USER)) {
            session.setAttribute("SESSION_USER_ROLE", "USER");
        }
    }

    public static User getSessionUser(HttpSession httpSession) {
        return (User) httpSession.getAttribute("SESSION_USER");
    }

    public static RoleType getSessionUserRole(User user) {
        return user.getRoles().iterator().next().getType();
    }

    public static void removeSessionUser(HttpServletRequest request) {
        HttpSession session = request.getSession();

        session.removeAttribute("SESSION_USER");
        session.removeAttribute("SESSION_USER_ROLE");
    }

}