package net.therap.converter;

import net.therap.model.Tag;
import net.therap.service.ProblemService;
import net.therap.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.Set;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Component
public class StringArrayToTagSetConverter implements Converter<String[], Set<Tag>> {

    @Autowired
    private TagService tagService;

    @Override
    public Set<Tag> convert(String[] source) {
        Set<Tag> tagSet = new HashSet<Tag>();

        for (String tagName : source) {
            Tag tag = tagService.getByName(tagName);
            tagSet.add(tag);
        }

        return tagSet;
    }

}