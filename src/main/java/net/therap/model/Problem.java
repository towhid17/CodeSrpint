package net.therap.model;

import net.therap.utils.SubmissionStatus;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Set;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Entity
public class Problem implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "problemSeq")
    @SequenceGenerator(name = "problemSeq", sequenceName = "problem_seq", allocationSize = 1)
    private Integer id;

    @NotEmpty(message = "is required")
    @Size(max = 100, message = "must be less than 100 characters")
    @Column(nullable = false)
    private String title;

    @NotEmpty(message = "is required")
    @Size(max = 500, message = "must be less than 500 characters")
    @Column(nullable = false)
    private String description;

    @OneToOne(mappedBy = "problem", cascade = CascadeType.ALL, orphanRemoval = true)
    private Editorial editorial;

    @ManyToOne
    @JoinColumn(name = "difficulty_id")
    private Difficulty difficulty;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    @OneToMany(mappedBy = "problem", cascade = CascadeType.ALL)
    private Set<Example> examples;

    @OneToMany(mappedBy = "problem", cascade = CascadeType.ALL)
    private Set<Constraint> constraints;

    @OneToMany(mappedBy = "problem", cascade = CascadeType.ALL)
    private Set<Submission> submissions;

    @ManyToMany
    @JoinTable(name = "problem_tag",
            joinColumns = @JoinColumn(name = "problem_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id"))
    private Set<Tag> tags;

    private Boolean deleted;

    @Version
    private Integer version;

    @Transient
    private Integer acceptanceRate;

    @Transient
    private SubmissionStatus currentUserSubmissionStatus;

    public Problem() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Difficulty getDifficulty() {
        return difficulty;
    }

    public void setDifficulty(Difficulty difficulty) {
        this.difficulty = difficulty;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Set<Tag> getTags() {
        return tags;
    }

    public void setTags(Set<Tag> tags) {
        this.tags = tags;
    }

    public Editorial getEditorial() {
        return editorial;
    }

    public void setEditorial(Editorial editorial) {
        this.editorial = editorial;
    }

    public Set<Example> getExamples() {
        return examples;
    }

    public void setExamples(Set<Example> examples) {
        this.examples = examples;
    }

    public Set<Constraint> getConstraints() {
        return constraints;
    }

    public void setConstraints(Set<Constraint> constraints) {
        this.constraints = constraints;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Set<Submission> getSubmissions() {
        return submissions;
    }

    public void setSubmissions(Set<Submission> submissions) {
        this.submissions = submissions;
    }

    public Integer getAcceptanceRate() {
        return acceptanceRate;
    }

    public void setAcceptanceRate(Integer acceptanceRate) {
        this.acceptanceRate = acceptanceRate;
    }

    public SubmissionStatus getCurrentUserSubmissionStatus() {
        return currentUserSubmissionStatus;
    }

    public void setCurrentUserSubmissionStatus(SubmissionStatus currentUserSubmissionStatus) {
        this.currentUserSubmissionStatus = currentUserSubmissionStatus;
    }

    @Override
    public boolean equals(Object problem) {
        if (this == problem) {
            return true;
        }

        if (isNull(problem) || getClass() != problem.getClass()) {
            return false;
        }

        Problem that = (Problem) problem;

        if (isNull(this.id) || isNull(that.id)) {
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

    public boolean isNew() {
        return isNull(this.id);
    }
}