package net.therap.service;

import net.therap.model.Problem;
import net.therap.model.Submission;
import net.therap.model.User;
import net.therap.utils.SubmissionStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
import java.util.Set;

/**
 * @author towhidul.islam
 * @since 10/1/23
 */
@Service
public class SubmissionService {

    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void saveSubmission(Submission submission) {
        em.persist(submission);
    }

    public List<Submission> getSubmissionListByUserAndProblem(User user, Problem problem) {
        return em.createQuery("SELECT s FROM Submission s WHERE s.user = :user AND s.problem = :problem", Submission.class)
                .setParameter("user", user)
                .setParameter("problem", problem)
                .getResultList();
    }

    public Set<Submission> getSubmissionListByUser(User user) {
        user = em.find(User.class, user.getId());

        return user.getSubmissions();
    }

    public List<Submission> getSubmissionListByStatus(SubmissionStatus submissionStatus) {
        return em.createQuery("SELECT s FROM Submission s WHERE s.status = :submissionStatus", Submission.class)
                .setParameter("submissionStatus", submissionStatus)
                .getResultList();
    }

    @Transactional
    public void updateSubmission(Submission submission) {
        em.merge(submission);
    }

    public Submission find(int submissionId) {
        return em.find(Submission.class, submissionId);
    }

    public List<Submission> getSubmissionListOfProblemByStatus(Problem problem, SubmissionStatus submissionStatus) {
        return em.createQuery("SELECT s FROM Submission s WHERE s.problem = :problem AND s.status = :submissionStatus", Submission.class)
                .setParameter("problem", problem)
                .setParameter("submissionStatus", submissionStatus)
                .getResultList();
    }

}