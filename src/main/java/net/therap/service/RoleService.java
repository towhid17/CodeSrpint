package net.therap.service;

import net.therap.model.Role;
import net.therap.model.User;
import net.therap.utils.RoleType;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Set;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Service
public class RoleService {

    @PersistenceContext
    private EntityManager em;

    public Role getRoleByType(RoleType roleType) {
        return em.createQuery("SELECT r FROM Role r WHERE r.type = :type", Role.class)
                .setParameter("type", roleType)
                .getResultList().get(0);
    }

    public Set<User> getAllModerators() {
        Role role = getRoleByType(RoleType.MODERATOR);

        return role.getUsers();
    }

}