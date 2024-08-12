package net.therap.controller;

import net.therap.helper.CodeExecutionHelper;
import net.therap.helper.SubmissionHelper;
import net.therap.model.Submission;
import net.therap.service.ProblemService;
import net.therap.service.SubmissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

import static net.therap.helper.AuthorizationHelper.checkAccess;
import static net.therap.utils.RoleType.USER;

/**
 * @author towhidul.islam
 * @since 10/3/23
 */
@Controller
@RequestMapping(value = "/code")
public class CodeExecutionController {

    @Autowired
    private SubmissionService submissionService;

    @Autowired
    private SubmissionHelper submissionHelper;

    @Autowired
    private ProblemService problemService;

    @Autowired
    private CodeExecutionHelper codeExecutionHelper;

    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public String showCode(ModelMap model) {
        return "codeEditor";
    }

    @RequestMapping(value = "/saveFile", method = RequestMethod.POST)
    public String saveFile(@RequestParam("code") String code,
                           @RequestParam("problemId") int problemId,
                           HttpSession httpSession) {

        checkAccess(httpSession, USER);

        codeExecutionHelper.saveFile(code);

        Submission submission = submissionHelper.getSubmission(code.getBytes(), problemId, httpSession, ".java");

        submissionService.saveSubmission(submission);

        return "redirect:/problem/" + problemId;
    }

    @RequestMapping(value = "/run", method = RequestMethod.POST)
    public ResponseEntity<String> executeJava(@RequestParam("code") String code) {
        codeExecutionHelper.saveFile(code);

        return ResponseEntity.ok(codeExecutionHelper.executeJavaFile());
    }

}