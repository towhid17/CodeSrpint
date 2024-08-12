package net.therap.service;

import net.therap.model.User;

import javax.persistence.EntityManager;

import static net.therap.utils.JpaEntityManagerFactory.INSTANCE;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
public class LoginService {

    public static User getUserByUserName(String userName) {
        EntityManager em = INSTANCE.getEntityManager();

        try {
            return em.createQuery("SELECT u FROM User u WHERE u.userName = :userName", User.class)
                    .setParameter("userName", userName)
                    .getSingleResult();

        } catch (Exception exception) {
            return null;
        }
    }

}