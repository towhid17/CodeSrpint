package net.therap.controller;

import net.therap.dto.CategoryDto;
import net.therap.model.Category;
import net.therap.service.CategoryService;
import net.therap.validator.CategoryValidator;
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
 * @since 10/4/23
 */
@Controller
@RequestMapping(value = "/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CategoryValidator validator;

    @RequestMapping(value = "/list", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<CategoryDto>> getList(HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        List<CategoryDto> categoryDtoList = categoryService.getCategoryList().stream()
                .map(CategoryDto::new)
                .collect(Collectors.toList());

        return ResponseEntity.ok(categoryDtoList);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseEntity<String> saveOrUpdate(@RequestParam("name") String name,
                                               @RequestParam(value = "id", required = false) Integer id,
                                               HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        Category category = new Category(id, name);
        BindingResult bindingResult = new BeanPropertyBindingResult(category, "category");

        validator.validate(category, bindingResult);

        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getFieldError().getDefaultMessage());
        }

        categoryService.saveOrUpdate(category);

        return ResponseEntity.ok("Successfully saved#"+ category.getId());
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(@RequestParam("id") int id, HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        Category category = categoryService.find(id);

        if (isNull(category)) {
            ResponseEntity.badRequest().body("Category not found");
        }

        categoryService.delete(category);

        return ResponseEntity.ok("Successfully deleted category");
    }

}