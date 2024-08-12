package net.therap.helper;

import net.therap.dto.UserHistoryDto;
import net.therap.model.Problem;
import net.therap.model.Submission;
import net.therap.model.User;
import net.therap.service.ProblemService;
import net.therap.utils.SubmissionStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.Set;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthenticationHelper.getSessionUser;

/**
 * @author towhidul.islam
 * @since 10/8/23
 */
@Component
public class UserHelper {

    @Autowired
    private ProblemService problemService;

    public void setUserHistoryDto(HttpSession httpSession, ModelMap modelMap) {
        User user = getSessionUser(httpSession);

        if (isNull(user)) {
            return;
        }

        UserHistoryDto userHistoryDto = new UserHistoryDto();

        Set<Problem> problemSet = problemService.getProblemList();

        userHistoryDto.setTotalProblems(problemSet.size());
        userHistoryDto.setTotalHardProblems((int) problemSet.stream().filter(problem -> problem.getDifficulty().getName().equals("Hard")).count());
        userHistoryDto.setTotalMediumProblems((int) problemSet.stream().filter(problem -> problem.getDifficulty().getName().equals("Medium")).count());
        userHistoryDto.setTotalEasyProblems((int) problemSet.stream().filter(problem -> problem.getDifficulty().getName().equals("Easy")).count());

        Set<Submission> submissions = user.getSubmissions();

        if (isNull(submissions)) {
            submissions = new HashSet<>();
        }

        userHistoryDto.setTotalSubmissions(submissions.size());

        userHistoryDto.setTotalProblemsAccepted((int) submissions.stream()
                .filter(submission -> submission.getStatus().equals(SubmissionStatus.SUCCEED)).count());

        userHistoryDto.setTotalHardProblemsAccepted((int) submissions.stream()
                .filter(submission -> submission.getStatus().equals(SubmissionStatus.SUCCEED) && submission.getProblem().getDifficulty().getName().equals("Hard")).count());

        userHistoryDto.setTotalMediumProblemsAccepted((int) submissions.stream()
                .filter(submission -> submission.getStatus().equals(SubmissionStatus.SUCCEED) && submission.getProblem().getDifficulty().getName().equals("Medium")).count());

        userHistoryDto.setTotalEasyProblemsAccepted((int) submissions.stream()
                .filter(submission -> submission.getStatus().equals(SubmissionStatus.SUCCEED) && submission.getProblem().getDifficulty().getName().equals("Easy")).count());

        modelMap.addAttribute("userHistoryDto", userHistoryDto);
    }

}