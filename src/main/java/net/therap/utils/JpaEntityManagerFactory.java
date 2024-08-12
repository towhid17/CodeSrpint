package net.therap.utils;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * @author towhidul.islam
 * @since 7/17/23
 */
public enum JpaEntityManagerFactory {

    INSTANCE;

    private final EntityManager em;

    JpaEntityManagerFactory() {
        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("emf");
        this.em = entityManagerFactory.createEntityManager();
    }

    public EntityManager getEntityManager() {
        return em;
    }

}