package net.therap.validator;

import net.therap.model.Tag;
import net.therap.service.TagService;
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
public class TagValidator implements Validator {

    @Autowired
    private TagService tagService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Tag.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Tag tag = (Tag) target;

        if (isNull(tag.getName()) || tag.getName().isEmpty()) {
            errors.rejectValue("name", "tag.name", "Tag name is required.");

            return;

        } else if (nonNull(tag.getId())) {
            Tag tagFromDb = tagService.find(tag.getId());

            if (isNull(tagFromDb)) {
                errors.rejectValue("id", "tag.id", "Tag not found.");

                return;
            }
        }

        if (nonNull(tagService.getByName(tag.getName()))) {
            errors.rejectValue("name", "tag.name", "Tag already exists.");
        }
    }

}