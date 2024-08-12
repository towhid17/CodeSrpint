package net.therap.controller;

import net.therap.exception.NotFoundException;
import net.therap.model.Example;
import net.therap.model.Problem;
import net.therap.service.ExampleService;
import net.therap.service.ProblemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthorizationHelper.checkAccess;
import static net.therap.utils.RoleType.ADMIN;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Controller
@RequestMapping(value = "/example")
@SessionAttributes("problem")
public class ExampleController {

    @Autowired
    private ExampleService exampleService;

    @Autowired
    private ProblemService problemService;

    @InitBinder("problem")
    public void initBinder(WebDataBinder binder) {
        binder.setDisallowedFields("*");
    }

    @RequestMapping(value = "add/problem/{problemId}", method = RequestMethod.GET)
    public String showCreateExample(@PathVariable int problemId, ModelMap modelMap, HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        Problem problem = problemService.find(problemId);

        if (isNull(problem)) {
            throw new NotFoundException("Problem not found");
        }

        modelMap.addAttribute("problem", problem);
        modelMap.addAttribute("exampleList", problem.getExamples());
        modelMap.addAttribute("example", new Example());

        return "createExample";
    }

    @RequestMapping(value = "add", method = RequestMethod.POST)
    public String addExample(@Valid @ModelAttribute("example") Example example,
                             BindingResult bindingResult,
                             @ModelAttribute("problem") Problem problem,
                             ModelMap modelMap,
                             HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        if (bindingResult.hasErrors()) {
            modelMap.addAttribute("exampleList", problem.getExamples());

            return "createExample";
        }

        example.setProblem(problem);

        exampleService.createExample(example);

        return "redirect:/example/add/problem/" + problem.getId();
    }

    @RequestMapping(value = "remove", method = RequestMethod.POST)
    public String deleteExample(@RequestParam("exampleId") int exampleId,
                                @ModelAttribute("problem") Problem problem,
                                HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        Example example = exampleService.find(exampleId);

        if (isNull(example)) {
            throw new NotFoundException("Example not found");
        }

        exampleService.deleteExample(example);

        return "redirect:/example/add/problem/" + problem.getId();
    }

}