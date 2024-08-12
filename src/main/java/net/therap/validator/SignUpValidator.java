package net.therap.validator;

import net.therap.model.User;
import net.therap.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;

/**
 * @author towhidul.islam
 * @since 10/11/23
 */
@Component
public class SignUpValidator implements Validator {

    @Autowired
    private UserService userService;

    @Override
    public boolean supports(Class<?> clazz) {
        return User.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        User user = (User) target;

        if(nonNull(userService.getByUserName(user.getUserName()))) {
            errors.rejectValue("userName", "user.userName", "Username already exists.");
        }

        if(nonNull(userService.getByEmail(user.getEmail()))) {
            errors.rejectValue("email", "user.email", "A account with this email already exists.");
        }

        if (isNull(user.getConfirmPassword()) || user.getConfirmPassword().isEmpty()) {
            errors.rejectValue("confirmPassword", "password.empty", "is required.");

        } else if (!user.getPassword().equals(user.getConfirmPassword())) {
            errors.rejectValue("confirmPassword", "password.mismatch", "Passwords do not match.");
        }
    }

}