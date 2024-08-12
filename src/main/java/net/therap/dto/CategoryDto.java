package net.therap.dto;

import net.therap.model.Category;
import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * @author towhidul.islam
 * @since 10/7/23
 */
@Component
public class CategoryDto implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;

    private String name;

    public CategoryDto() {
    }

    public CategoryDto(Category category) {
        this.id = category.getId();
        this.name = category.getName();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }

        if (!(o instanceof TagDto)) {
            return false;
        }

        TagDto tagDto = (TagDto) o;

        return getName() != null ? getName().equals(tagDto.getName()) : tagDto.getName() == null;
    }

    @Override
    public int hashCode() {
        return getName() != null ? getName().hashCode() : 0;
    }

}