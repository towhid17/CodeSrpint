package net.therap.controller;

import net.therap.exception.NotFoundException;
import net.therap.model.Editorial;
import net.therap.model.Problem;
import net.therap.model.EditorialRating;
import net.therap.model.User;
import net.therap.service.EditorialService;
import net.therap.service.ProblemService;
import net.therap.service.EditorialRatingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthenticationHelper.getSessionUser;
import static net.therap.helper.AuthorizationHelper.checkAccess;
import static net.therap.utils.RoleType.ADMIN;
import static net.therap.utils.RoleType.USER;

/**
 * @author towhidul.islam
 * @since 9/27/23
 */
@Controller
@RequestMapping(value = "/editorial")
@SessionAttributes("problem")
public class EditorialController {

    @Autowired
    private EditorialService editorialService;

    @Autowired
    private EditorialRatingService editorialRatingService;

    @Autowired
    private ProblemService problemService;

    @InitBinder("problem")
    public void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("*");
    }

    @RequestMapping(value = "/create/problem/{problemId}", method = RequestMethod.GET)
    public String showEditorial(ModelMap modelMap, @PathVariable int problemId, HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        Problem problem = problemService.find(problemId);

        if (isNull(problem)) {
            throw new NotFoundException("Problem not found");
        }

        Editorial editorial = problem.getEditorial();

        if (isNull(editorial)) {
            editorial = new Editorial();
        }

        modelMap.addAttribute("editorial", editorial);
        modelMap.addAttribute("problem", problem);

        return "createEditorial";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addEditorial(@Valid @ModelAttribute("editorial") Editorial editorial,
                               BindingResult bindingResult,
                               @ModelAttribute("problem") Problem problem,
                               HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        if (bindingResult.hasErrors()) {
            return "createEditorial";
        }

        editorial.setProblem(problem);

        editorialService.saveOrUpdate(editorial);

        return "redirect:/problem/" + problem.getId();
    }

    @RequestMapping(value = "rating/save", method = RequestMethod.POST)
    public ResponseEntity<String> saveOrUpdateRating(@RequestParam("rating") int currentValue,
                                                     @RequestParam("editorialId") int editorialId,
                                                     HttpSession httpSession) {

        checkAccess(httpSession, USER);

        User user = getSessionUser(httpSession);

        Editorial editorial = editorialService.find(editorialId);
        EditorialRating editorialRating = editorialRatingService.findByUserAndEditorial(user, editorial);

        editorialService.saveOrUpdateEditorialAndRating(editorial, editorialRating, user, currentValue);

        return ResponseEntity.ok("Rating saved#" + editorial.getAverageRating() + "#" + editorial.getNumOfRating());
    }

}