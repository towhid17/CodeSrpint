package net.therap.propertyEditor;

import net.therap.model.Difficulty;
import net.therap.service.DifficultyService;
import net.therap.service.ProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.beans.PropertyEditorSupport;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Component
public class DifficultyPropertyEditor extends PropertyEditorSupport {

    @Autowired
    private DifficultyService difficultyService;

    @Override
    public void setAsText(String text) throws IllegalArgumentException {
        Difficulty difficulty = difficultyService.getByName(text);

        setValue(difficulty);
    }

    @Override
    public String getAsText() {
        Difficulty difficulty = (Difficulty) getValue();

        return difficulty != null ? difficulty.getName() : "";
    }

}