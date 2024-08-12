package net.therap.service;

import net.therap.model.*;
import net.therap.utils.SubmissionStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static net.therap.helper.AuthenticationHelper.getSessionUser;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Service
public class ProblemService {

    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void saveOrUpdate(Problem problem) {
        if (problem.isNew()) {
            em.persist(problem);

        } else {
            em.merge(problem);
        }
    }

    public Problem find(int id) {
        return em.find(Problem.class, id);
    }

    public Set<Problem> getProblemList() {
        List<Problem> problemList = em.createQuery("SELECT p FROM Problem p", Problem.class).getResultList();

        return new HashSet<>(problemList);
    }

    @Transactional
    public void setProblemDeleted(int problemId, boolean b) {
        em.createQuery("UPDATE Problem p SET p.deleted = :deleted WHERE p.id = :id")
                .setParameter("deleted", b)
                .setParameter("id", problemId)
                .executeUpdate();
    }

    public Set<Problem> getProblemListByStatus(String status, HttpSession httpSession) {
        User user = getSessionUser(httpSession);

        Set<Problem> problemList;

        if (status.equals("Accepted")) {
            Set<Submission> submissionSet = user.getSubmissions().stream()
                    .filter(submission -> submission.getStatus().equals(SubmissionStatus.SUCCEED))
                    .collect(Collectors.toSet());

            problemList = submissionSet.stream().map(Submission::getProblem).collect(Collectors.toSet());

        } else if (status.equals("Attempted")) {
            Set<Submission> submissionSet = user.getSubmissions().stream()
                    .filter(submission -> submission.getStatus().equals(SubmissionStatus.WRONG) || submission.getStatus().equals(SubmissionStatus.PENDING))
                    .collect(Collectors.toSet());

            problemList = submissionSet.stream().map(Submission::getProblem).collect(Collectors.toSet());

        } else {
            Set<Submission> submissionSet = user.getSubmissions();

            Set<Problem> allProblemList = getProblemList();

            List<Problem> problemListUserHasSubmission = submissionSet.stream().map(Submission::getProblem).collect(Collectors.toList());

            problemList = allProblemList.stream()
                    .filter(problem -> !problemListUserHasSubmission.contains(problem))
                    .collect(Collectors.toSet());
        }

        return problemList;
    }

}