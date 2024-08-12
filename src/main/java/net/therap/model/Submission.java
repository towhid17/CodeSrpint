package net.therap.model;

import net.therap.utils.SubmissionStatus;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 10/1/23
 */
@Entity
public class Submission implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "submissionSeq")
    @SequenceGenerator(name = "submissionSeq", sequenceName = "submission_seq", allocationSize = 1)
    private Integer id;

    @NotNull(message = "is required")
    private byte[] script;

    @NotNull(message = "is required")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date submissionDate;

    @Enumerated(EnumType.STRING)
    private SubmissionStatus status;

    @NotNull(message = "is required")
    private String fileExtension;

    @ManyToOne
    @JoinColumn(name = "problem_id")
    private Problem problem;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Version
    private Integer version;

    public Submission() {
    }

    public Submission(byte[] file, Date submissionDate, SubmissionStatus status, Problem problem, User user, String fileExtension) {
        this.script = file;
        this.submissionDate = submissionDate;
        this.status = status;
        this.problem = problem;
        this.user = user;
        this.fileExtension = fileExtension;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public byte[] getScript() {
        return script;
    }

    public void setScript(byte[] script) {
        this.script = script;
    }

    public Date getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(Date submissionDate) {
        this.submissionDate = submissionDate;
    }

    public SubmissionStatus getStatus() {
        return status;
    }

    public void setStatus(SubmissionStatus status) {
        this.status = status;
    }

    public Problem getProblem() {
        return problem;
    }

    public void setProblem(Problem problem) {
        this.problem = problem;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getFileExtension() {
        return fileExtension;
    }

    public void setFileExtension(String fileExtension) {
        this.fileExtension = fileExtension;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    @Override
    public boolean equals(Object submission) {
        if (this == submission) {
            return true;
        }

        if (isNull(submission) || getClass() != submission.getClass()) {
            return false;
        }

        Submission that = (Submission) submission;

        if (isNull(id) || isNull(that.id)) {
            return false;
        }

        return id.equals(that.id);
    }

    @Override
    public int hashCode() {
        if (isNull(id)) {
            return 0;
        }

        return id.hashCode();
    }

}