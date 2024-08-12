package net.therap.propertyEditor;

import net.therap.model.Category;
import net.therap.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.beans.PropertyEditorSupport;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Component
public class CategoryPropertyEditor extends PropertyEditorSupport {

    @Autowired
    private CategoryService categoryService;

    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        Category category = categoryService.getByName(text);

        setValue(category);
    }

    @Override
    public String getAsText() {
        Category category = (Category) getValue();

        return category != null ? category.getName() : "";
    }

}