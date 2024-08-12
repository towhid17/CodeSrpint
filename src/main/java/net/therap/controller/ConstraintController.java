package net.therap.controller;

import net.therap.exception.NotFoundException;
import net.therap.model.Constraint;
import net.therap.model.Problem;
import net.therap.service.ConstraintService;
import net.therap.service.ProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthorizationHelper.checkAccess;
import static net.therap.utils.RoleType.ADMIN;

/**
 * @author towhidul.islam
 * @since 9/27/23
 */
@Controller
@RequestMapping(value = "/constraint")
@SessionAttributes("problem")
public class ConstraintController {

    @Autowired
    private ConstraintService constraintService;

    @Autowired
    private ProblemService problemService;

    @InitBinder("problem")
    public void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("*");
    }

    @RequestMapping(value = "add/problem/{problemId}", method = RequestMethod.GET)
    public String showCreateConstraint(@PathVariable int problemId, ModelMap modelMap, HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        Problem problem = problemService.find(problemId);

        if (isNull(problem)) {
            throw new NotFoundException("Problem not found");
        }

        modelMap.addAttribute("problem", problem);
        modelMap.addAttribute("constraintList", problem.getConstraints());
        modelMap.addAttribute("constraint", new Constraint());

        return "createConstraint";
    }

    @RequestMapping(value = "add", method = RequestMethod.POST)
    public String addConstraint(@Valid @ModelAttribute("constraint") Constraint constraint,
                                BindingResult bindingResult,
                                @ModelAttribute("problem") Problem problem,
                                ModelMap modelMap,
                                HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        if (bindingResult.hasErrors()) {
            modelMap.addAttribute("constraintList", problem.getConstraints());

            return "createConstraint";
        }

        constraint.setProblem(problem);

        constraintService.createConstraint(constraint);

        return "redirect:/constraint/add/problem/" + problem.getId();
    }

    @RequestMapping(value = "remove", method = RequestMethod.POST)
    public String removeConstraint(@RequestParam("constraintId") int constraintId,
                                   @ModelAttribute("problem") Problem problem,
                                   HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        Constraint constraint = constraintService.find(constraintId);

        if (isNull(constraint)) {
            throw new NotFoundException("Constraint not found");
        }

        constraintService.deleteConstraint(constraint);

        return "redirect:/constraint/add/problem/" + problem.getId();
    }

}