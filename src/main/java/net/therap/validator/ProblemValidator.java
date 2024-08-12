package net.therap.validator;

import net.therap.exception.NotFoundException;
import net.therap.model.Problem;
import net.therap.model.User;
import net.therap.utils.RoleType;

import javax.servlet.http.HttpSession;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthenticationHelper.getSessionUser;
import static net.therap.helper.AuthenticationHelper.getSessionUserRole;
import static net.therap.utils.RoleType.ADMIN;

/**
 * @author towhidul.islam
 * @since 10/19/23
 */
public class ProblemValidator {

    public static void validateProblem(Problem problem, HttpSession httpSession) {
        if (isNull(problem)) {
            throw new NotFoundException("Problem not found");
        }

        User user = getSessionUser(httpSession);
        RoleType roleType = getSessionUserRole(user);

        if (problem.getDeleted() && !roleType.equals(ADMIN)) {
            throw new NotFoundException("Problem not found");
        }
    }

    public static void validateProblemDeletion(Problem problem, boolean deleted) {
        if (isNull(problem)) {
            throw new NotFoundException("Problem not found");
        }

        if (problem.getDeleted() == deleted) {
            throw new NotFoundException("Problem not found");
        }
    }
}
