package net.therap.service;

import net.therap.model.Constraint;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

/**
 * @author towhidul.islam
 * @since 9/26/23
 */
@Service
public class ConstraintService {

    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void createConstraint(Constraint constraint) {
        em.persist(constraint);
    }

    @Transactional
    public void deleteConstraint(Constraint constraint) {
        em.remove(constraint);
    }

    public Constraint find(int id) {
        return em.find(Constraint.class, id);
    }

}