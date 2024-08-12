package net.therap.model;

import net.therap.utils.PasswordEncryptor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 9/25/23
 */
@Entity
@Table(name = "\"user\"")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "userSeq")
    @SequenceGenerator(name = "userSeq", sequenceName = "user_seq", allocationSize = 1)
    private Integer id;

    @NotEmpty
    @Column(nullable = false, unique = true)
    private String userName;

    @NotEmpty
    @Pattern(regexp = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$", message = "Invalid email address")
    @Column(nullable = false, unique = true)
    private String email;

    @NotEmpty
    @Column(nullable = false)
    @Convert(converter = PasswordEncryptor.class)
    private String password;

    @Transient
    private String confirmPassword;

    @Size(min = 2, max = 50, message = "First name must be between 2 and 50 characters long")
    private String fullName;

    @NotNull(message = "is required")
    @Past(message = "must be a past date")
    @Temporal(TemporalType.DATE)
    private Date dob;

    @OneToMany(mappedBy = "user")
    private Set<Submission> submissions;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<EditorialRating> editorialRatings;

    private Boolean lock;

    @Version
    private Integer version;

    @ManyToMany
    @JoinTable(name = "user_role",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles;

    public User() {
        this.roles = new HashSet<>();
    }

    public User(Integer id, String userName, String email, String password, String fullName, Date dob, Boolean lock) {
        this();

        this.id = id;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.dob = dob;
        this.lock = lock;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Boolean getLock() {
        return lock;
    }

    public void setLock(Boolean lock) {
        this.lock = lock;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public void addRole(Role role) {
        this.roles.add(role);
    }

    public Set<Submission> getSubmissions() {
        return submissions;
    }

    public void setSubmissions(Set<Submission> submissions) {
        this.submissions = submissions;
    }

    public boolean isNew() {
        return isNull(this.id);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }

        if (isNull(o) || getClass() != o.getClass()) {
            return false;
        }

        User user = (User) o;

        return Objects.equals(userName, user.getUserName());
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.userName);
    }

}