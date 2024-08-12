package net.therap.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Entity
public class Difficulty implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "difficultySeq")
    @SequenceGenerator(name = "difficultySeq", sequenceName = "difficulty_seq", allocationSize = 1)
    private Integer id;

    @Column(nullable = false, unique = true)
    private String name;

    @OneToMany(mappedBy = "difficulty", cascade = CascadeType.ALL)
    private Set<Problem> problems = new HashSet<>();

    @Version
    private Integer version;

    public Difficulty() {
    }

    public Difficulty(String name) {
        this.name = name;
    }

    public Difficulty(Integer id, String name) {
        this(name);

        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Problem> getProblems() {
        return problems;
    }

    public void setProblems(Set<Problem> problems) {
        this.problems = problems;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public boolean isNew() {
        return isNull(this.id);
    }

    @Override
    public boolean equals(Object difficulty) {
        if (this == difficulty) {
            return true;
        }

        if (isNull(difficulty) || getClass() != difficulty.getClass()) {
            return false;
        }

        Difficulty that = (Difficulty) difficulty;

        return name.equals(that.name);
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }

}