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
public class Example implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "exampleSeq")
    @SequenceGenerator(name = "exampleSeq", sequenceName = "example_seq", allocationSize = 1)
    private Integer id;
    
    @NotEmpty(message = "is required")
    private String input;

    @NotEmpty(message = "is required")
    private String output;

    @ManyToOne
    @JoinColumn(name = "problem_id")
    private Problem problem;

    @Version
    private Integer version;

    public Example() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getInput() {
        return input;
    }

    public void setInput(String input) {
        this.input = input;
    }

    public String getOutput() {
        return output;
    }

    public void setOutput(String output) {
        this.output = output;
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
    public boolean equals(Object example) {
        if (this == example) {
            return true;
        }

        if (isNull(example) || getClass() != example.getClass()) {
            return false;
        }

        Example that = (Example) example;

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