package net.therap.service;

import net.therap.model.Editorial;
import net.therap.model.EditorialRating;
import net.therap.model.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * @author towhidul.islam
 * @since 10/6/23
 */
@Service
public class EditorialRatingService {

    @PersistenceContext
    private EntityManager em;

    public EditorialRating findByUserAndEditorial(User user, Editorial editorial) {
        try {
            return em.createQuery("SELECT r FROM EditorialRating r WHERE r.user = :user AND r.editorial = :editorial", EditorialRating.class)
                    .setParameter("user", user)
                    .setParameter("editorial", editorial)
                    .getSingleResult();

        } catch (Exception e) {
            return null;
        }
    }

    @Transactional
    public void saveOrUpdate(EditorialRating editorialRating) {
        if (editorialRating.isNew()) {
            em.persist(editorialRating);

        } else {
            EditorialRating editorialRatingInDb = em.find(EditorialRating.class, editorialRating.getId());
            editorialRatingInDb.setValue(editorialRating.getValue());

            em.merge(editorialRatingInDb);
        }
    }
}