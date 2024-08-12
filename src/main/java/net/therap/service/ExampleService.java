package net.therap.service;

import net.therap.model.Example;
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
public class ExampleService {

    @PersistenceContext
    private EntityManager em;

    @Transactional
    public void createExample(Example example) {
        example.setId(null);
        em.persist(example);
    }

    @Transactional
    public void deleteExample(Example example) {
        em.remove(example);
    }

    public Example find(int id) {
        return em.find(Example.class, id);
    }

}