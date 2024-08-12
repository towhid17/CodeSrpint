package net.therap.service;

import net.therap.model.Editorial;
import net.therap.model.EditorialRating;
import net.therap.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import static java.util.Objects.isNull;

/**
 * @author towhidul.islam
 * @since 9/27/23
 */
@Service
public class EditorialService {

    @Autowired
    private EditorialRatingService editorialRatingService;

    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void saveOrUpdate(Editorial editorial) {
        if (editorial.isNew()) {
            em.persist(editorial);

        } else {
            em.merge(editorial);
        }
    }

    @Transactional
    public void delete(Editorial editorial) {
        em.remove(editorial);
    }

    public Editorial find(int editorialId) {
        return em.find(Editorial.class, editorialId);
    }

    @Transactional
    public void saveOrUpdateEditorialAndRating(Editorial editorial, EditorialRating editorialRating, User user, int currentValue) {
        editorialRating = prepareEditorialRating(editorialRating, editorial, user, currentValue);
        prepareEditorial(editorial, editorialRating);

        saveOrUpdate(editorial);
        editorialRatingService.saveOrUpdate(editorialRating);
    }

    private void prepareEditorial(Editorial editorial, EditorialRating editorialRating) {
        if (editorialRating.isNew()) {
            editorial.setNumOfRating(editorial.getNumOfRating() + 1);
            editorial.setAverageRating(((editorial.getAverageRating() * (editorial.getNumOfRating() -1)) + editorialRating.getValue()) / editorial.getNumOfRating());

        } else {
            editorial.setAverageRating(((editorial.getAverageRating() * editorial.getNumOfRating()) + editorialRating.getValue() - editorialRating.getPreviousValue()) / editorial.getNumOfRating());
        }
    }

    private EditorialRating prepareEditorialRating(EditorialRating editorialRating, Editorial editorial, User user, int currentValue) {
        if (isNull(editorialRating)) {
            editorialRating = new EditorialRating(user, editorial, currentValue);
            editorialRating.setPreviousValue(0);
        }

        editorialRating.setPreviousValue(editorialRating.getValue());
        editorialRating.setValue(currentValue);

        return editorialRating;
    }
}