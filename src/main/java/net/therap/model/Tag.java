package net.therap.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 9/23/23
 */
@Entity
public class Tag implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "tagSeq")
    @SequenceGenerator(name = "tagSeq", sequenceName = "tag_seq", allocationSize = 1)
    private Integer id;

    @Column(nullable = false, unique = true)
    private String name;

    @ManyToMany(mappedBy = "tags", cascade = CascadeType.ALL)
    private Set<Problem> problems = new HashSet<>();

    @Version
    private Integer version;

    public Tag() {
    }

    public Tag(String name) {
        this.name = name;
    }

    public Tag(Integer id, String name) {
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
        return isNull(id);
    }

    @Override
    public boolean equals(Object tag) {
        if (this == tag) {
            return true;
        }

        if (isNull(tag) || getClass() != tag.getClass()) {
            return false;
        }

        Tag that = (Tag) tag;

        return name.equals(that.name);
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }

}