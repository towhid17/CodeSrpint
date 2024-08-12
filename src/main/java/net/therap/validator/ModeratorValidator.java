package net.therap.validator;

import net.therap.exception.NotFoundException;
import net.therap.model.User;
import org.springframework.stereotype.Component;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthorizationHelper.hasRole;
import static net.therap.utils.RoleType.MODERATOR;

/**
 * @author towhidul.islam
 * @since 10/16/23
 */
@Component
public class ModeratorValidator {

    public void validateModeratorLock(User moderator, boolean isLocked) {
        if (isNull(moderator)) {
            throw new NotFoundException("Moderator doesn't exist");
        }

        if (!hasRole(moderator, MODERATOR)) {
            throw new IllegalArgumentException("User is not a moderator");
        }

        if (isLocked == moderator.getLock()) {
            throw new IllegalArgumentException("Moderator is already " + (isLocked ? "locked" : "unlocked"));
        }
    }

}