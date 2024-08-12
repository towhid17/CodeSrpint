package net.therap.validator;

import net.therap.model.Category;
import net.therap.service.CategoryService;
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
public class CategoryValidator implements Validator {

    @Autowired
    private CategoryService categoryService;

    @Override
    public boolean supports(Class<?> clazz) {
        return Category.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        Category category = (Category) target;

        if (isNull(category.getName()) || category.getName().isEmpty()) {
            errors.rejectValue("name", "category.name", "Category name is required.");

            return;

        } else if (nonNull(category.getId())) {
            Category categoryFromDb = categoryService.find(category.getId());

            if (isNull(categoryFromDb)) {
                errors.rejectValue("id", "category.id", "Category not found.");

                return;
            }
        }

        if (nonNull(categoryService.getByName(category.getName()))) {
            errors.rejectValue("name", "category.name", "Category already exists.");
        }
    }

}