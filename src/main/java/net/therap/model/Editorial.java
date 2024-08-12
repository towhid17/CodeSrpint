package net.therap.model;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.io.Serializable;
import java.util.Set;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Entity
public class Editorial implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "editorialSeq")
    @SequenceGenerator(name = "editorialSeq", sequenceName = "editorial_seq", allocationSize = 1)
    private Integer id;

    @NotEmpty(message = "is required")
    private String description;

    private double averageRating;

    private int numOfRating;

    @OneToOne
    @JoinColumn(name = "problem_id")
    private Problem problem;

    @OneToMany(mappedBy = "editorial", cascade = CascadeType.ALL)
    private Set<EditorialRating> editorialRatings;

    @Version
    private Integer version;

    public Editorial() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(double averageRating) {
        this.averageRating = averageRating;
    }

    public int getNumOfRating() {
        return numOfRating;
    }

    public void setNumOfRating(int numOfRating) {
        this.numOfRating = numOfRating;
    }

    public Problem getProblem() {
        return problem;
    }

    public void setProblem(Problem problem) {
        this.problem = problem;
    }

    public Set<EditorialRating> getRatings() {
        return editorialRatings;
    }

    public void setRatings(Set<EditorialRating> editorialRatings) {
        this.editorialRatings = editorialRatings;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public boolean isNew() {
        return isNull(id);
    }

    @Override
    public boolean equals(Object editorial) {
        if (this == editorial) {
            return true;
        }

        if (isNull(editorial) || getClass() != editorial.getClass()) {
            return false;
        }

        Editorial that = (Editorial) editorial;

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
