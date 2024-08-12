package net.therap.model;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import java.io.Serializable;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Entity
@Table(name = "\"constraint\"")
public class Constraint implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "constraintSeq")
    @SequenceGenerator(name = "constraintSeq", sequenceName = "constraint_seq", allocationSize = 1)
    private Integer id;

    @NotEmpty(message = "is required")
    private String description;

    @ManyToOne
    @JoinColumn(name = "problem_id")
    private Problem problem;

    @Version
    private Integer version;

    public Constraint() {
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

    public Problem getProblem() {
        return problem;
    }

    public void setProblem(Problem problem) {
        this.problem = problem;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    @Override
    public boolean equals(Object constraint) {
        if (this == constraint) {
            return true;
        }

        if (isNull(constraint) || getClass() != constraint.getClass()) {
            return false;
        }

        Constraint that = (Constraint) constraint;

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