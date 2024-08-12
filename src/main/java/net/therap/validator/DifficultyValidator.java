package net.therap.validator;

import net.therap.model.Difficulty;
import net.therap.service.DifficultyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;

/**
 * @author towhidul.islam
 * @since 10/12/23
 */
@Component
public class DifficultyValidator implements Validator {

    @Autowired
    private DifficultyService difficultyService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Difficulty.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Difficulty difficulty = (Difficulty) target;

        if (isNull(difficulty.getName()) || difficulty.getName().isEmpty()) {
            errors.rejectValue("name", "difficulty.name", "Difficulty name is required.");

            return;

        } else if (nonNull(difficulty.getId())) {
            Difficulty difficultyFromDb = difficultyService.find(difficulty.getId());

            if (isNull(difficultyFromDb)) {
                errors.rejectValue("id", "difficulty.id", "Difficulty not found.");

                return;
            }
        }

        if (nonNull(difficultyService.getByName(difficulty.getName()))) {
            errors.rejectValue("name", "difficulty.name", "Difficulty already exists.");
        }
    }

}