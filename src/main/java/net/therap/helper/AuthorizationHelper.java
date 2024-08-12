package net.therap.helper;

import net.therap.exception.NoAccessException;
import net.therap.model.User;
import net.therap.utils.RoleType;

import javax.servlet.http.HttpSession;

import static java.util.Objects.nonNull;
import static net.therap.helper.AuthenticationHelper.getSessionUser;

/**
 * @author towhidul.islam
 * @since 10/1/23
 */
public class AuthorizationHelper {

    public static boolean hasRole(User user, RoleType requiredRole) {
        return nonNull(user)
                && user.getRoles()
                .stream()
                .anyMatch(role -> role.getType().equals(requiredRole));
    }

    public static void checkAccess(HttpSession httpSession, RoleType... requiredRoles) {
        User user = getSessionUser(httpSession);

        if (nonNull(user)) {
            for (RoleType requiredRole : requiredRoles) {
                if (user.getRoles().stream().anyMatch(role -> role.getType().equals(requiredRole))) {
                    return;
                }
            }
        }

        throw new NoAccessException();
    }

}