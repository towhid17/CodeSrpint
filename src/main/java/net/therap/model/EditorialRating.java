package net.therap.model;

import javax.persistence.*;
import java.io.Serializable;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 10/6/23
 */
@Entity
public class EditorialRating implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ratingSeq")
    @SequenceGenerator(name = "ratingSeq", sequenceName = "rating_seq", allocationSize = 1)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "editorial_id")
    private Editorial editorial;

    private Integer value;

    @Version
    private Integer version;

    @Transient
    private int previousValue;

    public EditorialRating() {
    }

    public EditorialRating(User user, Editorial editorial, Integer value) {
        this.user = user;
        this.editorial = editorial;
        this.value = value;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Editorial getEditorial() {
        return editorial;
    }

    public void setEditorial(Editorial editorial) {
        this.editorial = editorial;
    }

    public Integer getValue() {
        return value;
    }

    public void setValue(Integer value) {
        this.value = value;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public int getPreviousValue() {
        return previousValue;
    }

    public void setPreviousValue(int previousValue) {
        this.previousValue = previousValue;
    }

    public boolean isNew() {
        return isNull(id);
    }

    @Override
    public boolean equals(Object rating) {
        if (this == rating) {
            return true;
        }

        if (isNull(rating) || getClass() != rating.getClass()) {
            return false;
        }

        EditorialRating that = (EditorialRating) rating;

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
