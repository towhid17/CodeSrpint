package net.therap.helper;

import net.therap.dto.SubmissionFileDto;
import net.therap.exception.NotFoundException;
import net.therap.model.Problem;
import net.therap.model.Submission;
import net.therap.model.User;
import net.therap.service.ProblemService;
import net.therap.service.SubmissionService;
import net.therap.service.UserService;
import net.therap.utils.RoleType;
import net.therap.utils.SubmissionStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import static java.util.Objects.isNull;
import static net.therap.helper.AuthenticationHelper.getSessionUser;
import static net.therap.helper.AuthenticationHelper.getSessionUserRole;

/**
 * @author towhidul.islam
 * @since 10/2/23
 */
@Component
public class SubmissionHelper {

    @Autowired
    private SubmissionService submissionService;

    @Autowired
    private ProblemService problemService;

    @Autowired
    private UserService userService;

    public String getMimeTypeForFileExtension(String fileExtension) {
        switch (fileExtension.toLowerCase()) {
            case "cpp":
                return "text/x-c++src";
            case "java":
                return "text/x-java";
            case "py":
                return "text/x-python";
            default:
                return "application/octet-stream";
        }
    }

    public Submission getSubmissionFromSubmissionDto(SubmissionFileDto submissionFileDto,
                                                     int problemId,
                                                     HttpSession httpSession) throws IOException {

        MultipartFile file = submissionFileDto.getSubmissionFile();

        String fileName = file.getOriginalFilename();
        String fileExtension = fileName.substring(fileName.lastIndexOf('.')).toLowerCase();

        return getSubmission(file.getBytes(), problemId, httpSession, fileExtension);
    }

    public Submission getSubmission(byte[] file, int problemId, HttpSession httpSession, String fileExtension) {
        Problem problem = problemService.find(problemId);
        User user = getSessionUser(httpSession);

        if (isNull(problem)) {
            throw new NotFoundException("Problem not found");
        }

        return new Submission(file, Date.from(Instant.now()), SubmissionStatus.PENDING, problem, user, fileExtension);
    }

    public List<Submission> getSubmissionList(HttpSession httpSession) {
        User user = getSessionUser(httpSession);
        RoleType roleType = getSessionUserRole(user);

        List<Submission> submissionList = new ArrayList<>();

        if (roleType == RoleType.MODERATOR) {
            submissionList = submissionService.getSubmissionListByStatus(SubmissionStatus.PENDING);

        } else if (roleType == RoleType.USER) {
            Set<Submission> submissionSet = submissionService.getSubmissionListByUser(user);

            submissionList.addAll(submissionSet);
        }

        return submissionList;
    }

    public List<Submission> getProblemSubmissions(User user, Problem problem) {
        RoleType roleType = getSessionUserRole(user);

        List<Submission> submissionList = new ArrayList<>();

        if (roleType == RoleType.MODERATOR) {
            submissionList = submissionService.getSubmissionListOfProblemByStatus(problem, SubmissionStatus.PENDING);

        } else if (roleType == RoleType.USER) {
            submissionList = submissionService.getSubmissionListByUserAndProblem(user, problem);
        }

        return submissionList;
    }

}