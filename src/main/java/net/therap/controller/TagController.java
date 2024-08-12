package net.therap.controller;

import net.therap.dto.TagDto;
import net.therap.model.Tag;
import net.therap.service.TagService;
import net.therap.validator.TagValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthorizationHelper.checkAccess;
import static net.therap.utils.RoleType.ADMIN;

/**
 * @author towhidul.islam
 * @since 9/29/23
 */
@Controller
@RequestMapping(value = "/tag")
public class TagController {

    @Autowired
    private TagService tagService;

    @Autowired
    private TagValidator validator;

    @RequestMapping(value = "/list", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<TagDto>> getList(HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        List<TagDto> tagDtoList = tagService.getTagList().stream()
                .map(TagDto::new)
                .collect(Collectors.toList());

        return ResponseEntity.ok(tagDtoList);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseEntity<String> saveOrUpdate(@RequestParam("name") String name,
                                               @RequestParam(value = "id", required = false) Integer id,
                                               HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        Tag tag = new Tag(id, name);
        BindingResult bindingResult = new BeanPropertyBindingResult(tag, "tag");

        validator.validate(tag, bindingResult);

        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getFieldError().getDefaultMessage());
        }

        tagService.saveOrUpdate(tag);

        return ResponseEntity.ok("Successfully saved#" + tag.getId());
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(@RequestParam("id") int id, HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        Tag tag = tagService.find(id);

        if (isNull(tag)) {
            return ResponseEntity.badRequest().body("Tag not found");
        }

        tagService.delete(tag);

        return ResponseEntity.ok("Successfully deleted tag");
    }

}