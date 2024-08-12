package net.therap.service;

import net.therap.model.Category;
import net.therap.model.Problem;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
import java.util.Set;

/**
 * @author towhidul.islam
 * @since 10/4/23
 */
@Service
public class CategoryService {

    @PersistenceContext
    private EntityManager em;

    public List<Category> getCategoryList() {
        return em.createQuery("SELECT m FROM Category m", Category.class).getResultList();
    }

    public Category getByName(String name) {
        try {
            return em.createQuery("SELECT m FROM Category m WHERE LOWER(m.name) = LOWER(:name)", Category.class)
                    .setParameter("name", name)
                    .getSingleResult();

        } catch (Exception exception) {
            return null;
        }
    }

    public Category find(int categoryId) {
        return em.find(Category.class, categoryId);
    }

    @Transactional
    public void saveOrUpdate(Category category) {
        if (category.isNew()) {
            em.persist(category);

        } else {
            Category categoryFromDb = find(category.getId());
            categoryFromDb.setName(category.getName());

            em.merge(categoryFromDb);
        }
    }

    @Transactional
    public void delete(Category category) {
        em.remove(category);
    }

    public Set<Problem> getProblemListByCategory(String categoryName) {
        Category category = getByName(categoryName);

        return category.getProblems();
    }

}