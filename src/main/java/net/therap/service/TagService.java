package net.therap.service;

import net.therap.model.Problem;
import net.therap.model.Tag;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
import java.util.Set;

/**
 * @author towhidul.islam
 * @since 9/29/23
 */
@Service
public class TagService {

    @PersistenceContext
    private EntityManager em;

    public List<Tag> getTagList() {
        return em.createQuery("SELECT m FROM Tag m", Tag.class).getResultList();
    }

    public Tag getByName(String name) {
        try {
            return em.createQuery("SELECT m FROM Tag m WHERE LOWER(m.name) = LOWER(:name)", Tag.class)
                    .setParameter("name", name)
                    .getSingleResult();

        } catch (Exception exception) {
            return null;
        }
    }

    @Transactional
    public void saveOrUpdate(Tag tag) {
        if (tag.isNew()) {
            em.persist(tag);

        } else {
            Tag tagFromDb = find(tag.getId());
            tagFromDb.setName(tag.getName());

            em.merge(tagFromDb);
        }
    }

    public Tag find(int tagId) {
        return em.find(Tag.class, tagId);
    }

    @Transactional
    public void delete(Tag tag) {
        em.remove(em.getReference(Tag.class, tag.getId()));
    }

    public Set<Problem> getProblemListByTag(String tagName) {
        Tag tag = getByName(tagName);

        return tag.getProblems();
    }

}