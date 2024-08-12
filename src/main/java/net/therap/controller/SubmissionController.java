package net.therap.controller;

import net.therap.dto.SubmissionFileDto;
import net.therap.exception.NotFoundException;
import net.therap.helper.SubmissionHelper;
import net.therap.model.Submission;
import net.therap.service.SubmissionService;
import net.therap.utils.SubmissionStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import static java.util.Objects.isNull;
import static java.util.Objects.nonNull;
import static net.therap.helper.AuthorizationHelper.checkAccess;
import static net.therap.utils.RoleType.MODERATOR;
import static net.therap.utils.RoleType.USER;

/**
 * @author towhidul.islam
 * @since 10/1/23
 */
@Controller
@RequestMapping("/submission")
public class SubmissionController {

    @Autowired
    private SubmissionService submissionService;

    @Autowired
    private SubmissionHelper submissionHelper;

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String saveSubmission(@Valid @ModelAttribute("submissionFileDto") SubmissionFileDto submissionFileDto,
                                 BindingResult bindingResult,
                                 @RequestParam("problemId") int problemId,
                                 HttpSession httpSession) throws IOException {

        checkAccess(httpSession, USER);

        if (bindingResult.hasErrors()) {
            httpSession.setAttribute("error", bindingResult.getRawFieldValue("submissionFile"));

            return "redirect:/problem/" + problemId;
        }

        Submission submission = submissionHelper.getSubmissionFromSubmissionDto(submissionFileDto, problemId, httpSession);

        submissionService.saveSubmission(submission);

        return "redirect:/problem/" + problemId;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listSubmission(ModelMap modelMap, HttpSession httpSession) {
        checkAccess(httpSession, MODERATOR, USER);

        List<Submission> submissionList = submissionHelper.getSubmissionList(httpSession);

        modelMap.addAttribute("submissionList", submissionList);
        modelMap.addAttribute("currentTab", "submission");
        modelMap.addAttribute("tabMode", "wide");

        return "submissionList";
    }

    @RequestMapping(value = "/approve", method = RequestMethod.POST)
    public String approveSubmission(@RequestParam("submissionId") int submissionId,
                                    @RequestParam(value = "problemId", required = false) Integer problemId,
                                    RedirectAttributes redirectAttributes,
                                    HttpSession httpSession) {

        checkAccess(httpSession, MODERATOR);

        Submission submission = submissionService.find(submissionId);

        if (isNull(submission)) {
            throw new NotFoundException("Submission not found");
        }

        submission.setStatus(SubmissionStatus.SUCCEED);

        submissionService.updateSubmission(submission);

        if (nonNull(problemId)) {
            redirectAttributes.addAttribute("tab", "problemSubmission");

            return "redirect:/problem/" + problemId;
        }

        return "redirect:/submission/list";
    }

    @RequestMapping(value = "/reject", method = RequestMethod.POST)
    public String rejectSubmission(@RequestParam("submissionId") int submissionId,
                                   @RequestParam(value = "problemId", required = false) Integer problemId,
                                   RedirectAttributes redirectAttributes,
                                   HttpSession httpSession) {

        checkAccess(httpSession, MODERATOR);

        Submission submission = submissionService.find(submissionId);

        submission.setStatus(SubmissionStatus.WRONG);

        submissionService.updateSubmission(submission);

        if (nonNull(problemId)) {
            redirectAttributes.addAttribute("tab", "problemSubmission");

            return "redirect:/problem/" + problemId;
        }

        return "redirect:/submission/list";
    }

    @Async
    @RequestMapping(value = "/download/{submissionId}", method = RequestMethod.GET)
    public void doDownload(@PathVariable("submissionId") int submissionId,
                           HttpServletRequest request,
                           HttpServletResponse response) throws IOException {

        checkAccess(request.getSession(), MODERATOR, USER);

        Submission submission = submissionService.find(submissionId);

        byte[] fileData = submission.getScript();
        String fileExtension = submission.getFileExtension().substring(1);

        response.setContentType(submissionHelper.getMimeTypeForFileExtension(fileExtension));
        response.setContentLength(fileData.length);

        String headerKey = "Content-Disposition";
        String headerValue = String.format("attachment; filename=\"script_%s.%s\"", submissionId, fileExtension);
        response.setHeader(headerKey, headerValue);

        OutputStream outStream = response.getOutputStream();

        outStream.write(fileData);
        outStream.close();
    }

    @RequestMapping(value = "/{submissionId}/textScript", method = RequestMethod.GET)
    public ResponseEntity<String> getTextScript(@PathVariable("submissionId") int submissionId, HttpSession httpSession) {
        checkAccess(httpSession, MODERATOR, USER);
        
        Submission submission = submissionService.find(submissionId);

        return ResponseEntity.ok(new String(submission.getScript()));
    }

}