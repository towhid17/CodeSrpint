package net.therap.service;

import net.therap.model.Difficulty;
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
public class DifficultyService {

    @PersistenceContext
    private EntityManager em;

    public List<Difficulty> getDifficultyList() {
        return em.createQuery("SELECT m FROM Difficulty m", Difficulty.class).getResultList();
    }

    public Difficulty getByName(String name) {
        try {
            return em.createQuery("SELECT m FROM Difficulty m WHERE LOWER(m.name) = LOWER(:name)", Difficulty.class)
                    .setParameter("name", name)
                    .getSingleResult();

        } catch (Exception exception) {
            return null;
        }
    }

    @Transactional
    public void saveOrUpdate(Difficulty difficulty) {
        if (difficulty.isNew()) {
            em.persist(difficulty);

        } else {
            Difficulty difficultyFromDb = find(difficulty.getId());
            difficultyFromDb.setName(difficulty.getName());

            em.merge(difficultyFromDb);
        }
    }

    public Difficulty find(int difficultyId) {
        return em.find(Difficulty.class, difficultyId);
    }

    @Transactional
    public void delete(Difficulty difficulty) {
        em.remove(difficulty);
    }

    public Set<Problem> getProblemListByDifficulty(String difficultyName) {
        Difficulty difficulty = getByName(difficultyName);

        return difficulty.getProblems();
    }

}