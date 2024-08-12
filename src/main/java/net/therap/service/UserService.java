package net.therap.service;

import net.therap.model.Role;
import net.therap.model.User;
import net.therap.utils.RoleType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import static java.util.Objects.nonNull;
import static net.therap.helper.AuthorizationHelper.hasRole;

/**
 * @author towhidul.islam
 * @since 9/25/23
 */
@Service
public class UserService {

    @Autowired
    RoleService roleService;

    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void saveOrUpdate(User user) {
        if (user.isNew()) {
            em.persist(user);

        } else {
            em.merge(user);
        }
    }

    @Transactional
    public void createUserByType(User user, RoleType roleType) {
        Role role = roleService.getRoleByType(roleType);

        user.addRole(role);
        user.setLock(false);

        saveOrUpdate(user);
    }

    public User getByUserName(String userName) {
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.userName = :userName", User.class)
                    .setParameter("userName", userName)
                    .getSingleResult();

        } catch (Exception exception) {
            return null;
        }
    }

    public Object getByEmail(String email) {
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();

        } catch (Exception exception) {
            return null;
        }
    }

    public User find(int id) {
        return em.find(User.class, id);
    }

    @Transactional
    public void updateLock(User user, boolean isLocked) {
        em.createQuery("UPDATE User u SET u.lock = :isLocked WHERE u.id = :userId")
                .setParameter("isLocked", isLocked)
                .setParameter("userId", user.getId())
                .executeUpdate();
    }

}