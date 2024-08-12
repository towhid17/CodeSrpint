package net.therap.controller;

import net.therap.dto.DifficultyDto;
import net.therap.model.Difficulty;
import net.therap.service.DifficultyService;
import net.therap.validator.DifficultyValidator;
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
@RequestMapping(value = "/difficulty")
public class DifficultyController {

    @Autowired
    private DifficultyService difficultyService;

    @Autowired
    private DifficultyValidator validator;

    @RequestMapping(value = "/list", method = RequestMethod.GET, produces = "application/json")
    public ResponseEntity<List<DifficultyDto>> getList(HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        List<DifficultyDto> difficultyDtoList = difficultyService.getDifficultyList().stream()
                .map(DifficultyDto::new)
                .collect(Collectors.toList());

        return ResponseEntity.ok(difficultyDtoList);
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ResponseEntity<String> saveOrUpdate(@RequestParam("name") String name,
                                               @RequestParam(value = "id", required = false) Integer id,
                                               HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        Difficulty difficulty = new Difficulty(id, name);
        BindingResult bindingResult = new BeanPropertyBindingResult(difficulty, "difficulty");

        validator.validate(difficulty, bindingResult);

        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getFieldError().getDefaultMessage());
        }

        difficultyService.saveOrUpdate(difficulty);

        return ResponseEntity.ok("Successfully saved#"+ difficulty.getId());
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public ResponseEntity<String> delete(@RequestParam("id") int id, HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        Difficulty difficulty = difficultyService.find(id);

        if (isNull(difficulty)) {
            return ResponseEntity.badRequest().body("Difficulty not found");
        }

        difficultyService.delete(difficulty);

        return ResponseEntity.ok("Successfully deleted difficulty");
    }

}
