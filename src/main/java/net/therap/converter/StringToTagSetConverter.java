package net.therap.converter;

import net.therap.model.Tag;
import net.therap.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;

import java.util.HashSet;
import java.util.Set;

/**
 * @author towhidul.islam
 * @since 10/7/23
 */
public class StringToTagSetConverter implements Converter<String, Set<Tag>> {

    @Autowired
    private TagService tagService;

    @Override
    public Set<Tag> convert(String source) {
        Set<Tag> tagSet = new HashSet<Tag>();

        Tag tag = tagService.getByName(source);
        tagSet.add(tag);

        return tagSet;
    }

}