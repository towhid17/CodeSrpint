package net.therap.model;

import net.therap.utils.RoleType;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Set;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 9/25/23
 */
@Entity
public class Role implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "roleSeq")
    @SequenceGenerator(name = "roleSeq", sequenceName = "role_seq", allocationSize = 1)
    private Integer id;

    @NotNull
    @Enumerated
    @Column(nullable = false)
    private RoleType type;

    @ManyToMany(mappedBy = "roles")
    private Set<User> users;

    @Version
    private Integer version;

    public Role() {
    }

    public Role(RoleType type) {
        this.type = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public RoleType getType() {
        return type;
    }

    public void setType(RoleType type) {
        this.type = type;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    @Override
    public boolean equals(Object role) {
        if (this == role) {
            return true;
        }

        if (isNull(role) || getClass() != role.getClass()) {
            return false;
        }

        Role that = (Role) role;

        return type == that.type;
    }

    @Override
    public int hashCode() {
        return type.hashCode();
    }

}