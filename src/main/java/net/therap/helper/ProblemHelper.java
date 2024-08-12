package net.therap.helper;

import net.therap.model.*;
import net.therap.service.CategoryService;
import net.therap.service.DifficultyService;
import net.therap.service.EditorialRatingService;
import net.therap.service.TagService;
import net.therap.utils.RoleType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Set;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthenticationHelper.getSessionUser;
import static net.therap.helper.AuthenticationHelper.getSessionUserRole;
import static net.therap.utils.SubmissionStatus.PENDING;
import static net.therap.utils.SubmissionStatus.SUCCEED;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Component
public class ProblemHelper {

    @Autowired
    private TagService tagService;

    @Autowired
    private DifficultyService difficultyService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private EditorialRatingService editorialRatingService;

    @Autowired
    private SubmissionHelper submissionHelper;

    @Autowired
    private UserHelper userHelper;


    public void setCreateProblemAttributes(ModelMap modelMap) {
        setAdditionalAttributeList(modelMap);

        modelMap.addAttribute("difficulty", new Difficulty());
        modelMap.addAttribute("category", new Category());
        modelMap.addAttribute("tag", new Tag());
    }

    public void setAdditionalAttributeList(ModelMap modelMap) {
        modelMap.addAttribute("difficultyList", difficultyService.getDifficultyList());
        modelMap.addAttribute("categoryList", categoryService.getCategoryList());
        modelMap.addAttribute("tagList", tagService.getTagList());
    }

    public void setAdditionalProblemAttributes(Set<Problem> problemSet, HttpSession httpSession, ModelMap modelMap) {
        setAdditionalAttributeList(modelMap);
        calculateAcceptanceRate(problemSet);

        User user = getSessionUser(httpSession);

        if (isNull(user)) {
            return;
        }

        RoleType roleType = getSessionUserRole(user);

        if (roleType.equals(RoleType.ADMIN)
                || roleType.equals(RoleType.MODERATOR)
                || isNull(user.getSubmissions())
                || user.getSubmissions().isEmpty()) {

            return;
        }

        setCurrentUserSubmissionStatus(problemSet, user);
    }

    private void calculateAcceptanceRate(Set<Problem> problemSet) {
        problemSet.forEach(problem -> {
            int totalSubmission = problem.getSubmissions().size();
            int totalAcceptedSubmission = (int) problem.getSubmissions().stream()
                    .filter(submission -> submission.getStatus().equals(SUCCEED))
                    .count();

            if (totalSubmission == 0) {
                problem.setAcceptanceRate(0);

            } else {
                problem.setAcceptanceRate((totalAcceptedSubmission * 100) / totalSubmission);
            }
        });

    }

    private void setCurrentUserSubmissionStatus(Set<Problem> problemSet, User user) {
        problemSet.forEach(problem -> {
            problem.getSubmissions().forEach(submission -> {
                if (submission.getUser().getId().equals(user.getId())) {
                    if (!SUCCEED.equals(problem.getCurrentUserSubmissionStatus())) {
                        if (!PENDING.equals(problem.getCurrentUserSubmissionStatus())) {
                            problem.setCurrentUserSubmissionStatus(submission.getStatus());
                        }
                    }
                }
            });
        });

    }

    public void setShowProblemAttributes(ModelMap modelMap, Problem problem, String tab, HttpSession httpSession) {
        User user = getSessionUser(httpSession);

        EditorialRating editorialRating = editorialRatingService.findByUserAndEditorial(user, problem.getEditorial());

        List<Submission> problemSubmissions = submissionHelper.getProblemSubmissions(user, problem);

        modelMap.addAttribute("problem", problem);
        modelMap.addAttribute("problemSubmissions", problemSubmissions);
        modelMap.addAttribute("rating", editorialRating);
        modelMap.addAttribute("currentTab", "problem");
        modelMap.addAttribute("tabMode", "wide");
        modelMap.addAttribute("tab", tab);
    }

    public void setProblemListAttributes(ModelMap modelMap, HttpSession httpSession, Set<Problem> problemSet) {
        setAdditionalProblemAttributes(problemSet, httpSession, modelMap);
        userHelper.setUserHistoryDto(httpSession, modelMap);

        modelMap.addAttribute("problemList", problemSet);
        modelMap.addAttribute("currentTab", "problem");
    }

}