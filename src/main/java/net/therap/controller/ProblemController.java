package net.therap.controller;

import net.therap.helper.ProblemHelper;
import net.therap.model.Category;
import net.therap.model.Difficulty;
import net.therap.model.Problem;
import net.therap.propertyEditor.CategoryPropertyEditor;
import net.therap.propertyEditor.DifficultyPropertyEditor;
import net.therap.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Set;

import static java.util.Objects.nonNull;
import static net.therap.helper.AuthorizationHelper.checkAccess;
import static net.therap.utils.RoleType.ADMIN;
import static net.therap.utils.RoleType.USER;
import static net.therap.validator.ProblemValidator.validateProblem;
import static net.therap.validator.ProblemValidator.validateProblemDeletion;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Controller
@RequestMapping(value = "/problem")
public class ProblemController {

    @Autowired
    private ProblemService problemService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private TagService tagService;

    @Autowired
    private DifficultyService difficultyService;

    @Autowired
    private SubmissionService submissionService;

    @Autowired
    private ProblemHelper problemHelper;

    @Autowired
    private CategoryPropertyEditor categoryPropertyEditor;

    @Autowired
    private DifficultyPropertyEditor difficultyPropertyEditor;

    @InitBinder("problem")
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Category.class, categoryPropertyEditor);
        binder.registerCustomEditor(Difficulty.class, difficultyPropertyEditor);
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }

    @RequestMapping(value = "/save", method = RequestMethod.GET)
    public String showCreateProblem(@RequestParam(name = "problemId", required = false) Integer problemId,
                                    ModelMap modelMap,
                                    HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        if (nonNull(problemId)) {
            Problem problem = problemService.find(problemId);
            modelMap.addAttribute("problem", problem);

        } else {
            modelMap.addAttribute("problem", new Problem());
        }

        problemHelper.setCreateProblemAttributes(modelMap);

        modelMap.addAttribute("currentTab", "problem");

        return "createProblem";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String createProblem(@Valid @ModelAttribute("problem") Problem problem,
                                BindingResult bindingResult,
                                ModelMap modelMap,
                                HttpSession httpSession) {

        checkAccess(httpSession, ADMIN);

        if (bindingResult.hasErrors()) {
            problemHelper.setCreateProblemAttributes(modelMap);

            return "createProblem";
        }

        problemService.saveOrUpdate(problem);

        modelMap.addAttribute("currentTab", "problem");

        return "redirect:/example/add/problem/" + problem.getId();
    }

    @RequestMapping(value = "{problemId}", method = RequestMethod.GET)
    public String showProblem(@PathVariable("problemId") int problemId,
                              ModelMap modelMap,
                              HttpSession httpSession,
                              @RequestParam(value = "tab", required = false) String tab) {

        Problem problem = problemService.find(problemId);

        validateProblem(problem, httpSession);

        problemHelper.setShowProblemAttributes(modelMap, problem, tab, httpSession);

        return "problem";
    }

    @RequestMapping(value = "list", method = RequestMethod.GET)
    public String showProblemList(ModelMap modelMap, HttpSession httpSession) {
        Set<Problem> problemSet = problemService.getProblemList();

        problemHelper.setProblemListAttributes(modelMap, httpSession, problemSet);

        return "problemList";
    }

    @RequestMapping(value = "list/tag/{tagName}", method = RequestMethod.GET)
    public String showProblemListByTag(@PathVariable("tagName") String tagName, ModelMap modelMap, HttpSession httpSession) {
        Set<Problem> problemSet = tagService.getProblemListByTag(tagName);

        problemHelper.setProblemListAttributes(modelMap, httpSession, problemSet);

        return "problemList";
    }

    @RequestMapping(value = "list/category/{categoryName}", method = RequestMethod.GET)
    public String showProblemListByCategory(@PathVariable("categoryName") String categoryName, ModelMap modelMap, HttpSession httpSession) {
        Set<Problem> problemSet = categoryService.getProblemListByCategory(categoryName);

        problemHelper.setProblemListAttributes(modelMap, httpSession, problemSet);

        return "problemList";
    }

    @RequestMapping(value = "list/difficulty/{difficultyName}", method = RequestMethod.GET)
    public String showProblemListByDifficulty(@PathVariable("difficultyName") String difficultyName, ModelMap modelMap, HttpSession httpSession) {
        Set<Problem> problemSet = difficultyService.getProblemListByDifficulty(difficultyName);

        problemHelper.setProblemListAttributes(modelMap, httpSession, problemSet);

        return "problemList";
    }

    @RequestMapping(value = "list/status", method = RequestMethod.POST)
    public String showProblemListByStatus(@RequestParam("status") String status, ModelMap modelMap, HttpSession httpSession) {
        checkAccess(httpSession, USER);

        Set<Problem> problemSet = problemService.getProblemListByStatus(status, httpSession);

        problemHelper.setProblemListAttributes(modelMap, httpSession, problemSet);

        return "problemList";
    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    public String deleteProblem(@RequestParam("problemId") int problemId,
                                @RequestParam("deleted") boolean deleted,
                                HttpSession httpSession) {
        checkAccess(httpSession, ADMIN);

        Problem problem = problemService.find(problemId);

        validateProblemDeletion(problem, deleted);

        problemService.setProblemDeleted(problemId, deleted);

        return "redirect:/problem/list";
    }
}
