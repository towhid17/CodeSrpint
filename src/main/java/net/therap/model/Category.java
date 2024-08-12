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
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "categorySeq")
    @SequenceGenerator(name = "categorySeq", sequenceName = "category_seq", allocationSize = 1)
    private Integer id;

    @Column(nullable = false, unique = true)
    private String name;

    @Version
    private Integer version;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL)
    private Set<Problem> problems = new HashSet<>();

    public Category() {
    }

    public Category(String name) {
        this.name = name;
    }

    public Category(Integer id, String name) {
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
    public boolean equals(Object category) {
        if (this == category) {
            return true;
        }

        if (isNull(category) || getClass() != category.getClass()) {
            return false;
        }

        Category that = (Category) category;

        return name.equals(that.name);
    }

    @Override
    public int hashCode() {
        return name.hashCode();
    }

}