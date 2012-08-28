package cn.im47.cms.common.service;

import java.io.Serializable;

/**
 * Generic Manager (Data Access Object) with common methods to CRUD POJOs.
 * <p/>
 * <p>Extend this interface if you want typesafe (no casting necessary) Manager's for your
 * domain objects.
 *
 * @param <T>  a type variable
 * @param <PK> the primary key for that type
 * @author baitao.jibt@gmail.com
 * @version 1.0
 * @since 2010-04-17
 */
public interface GenericManager<T, PK extends Serializable> {

    /**
     * Generic method to get an object based on class and identifier. An
     * ObjectRetrievalFailureException Runtime Exception is thrown if
     * nothing is found.
     *
     * @param id the identifier (primary key) of the object to get
     * @return a populated object
     * @see org.springframework.orm.ObjectRetrievalFailureException
     */
    T get(PK id);

    /**
     * Generic method to save an object - handles insert.  will set modified_time to
     * current time and will set created_time to current_system_time if it's an insert.
     *
     * @param object the object to save
     * @return the persisted object
     */
    long save(T object);

    /**
     * Generic method to update an object - handles update.  will set modified_time to
     * current time.
     *
     * @param object the object to save
     * @return the persisted object
     */
    long update(T object);

    /**
     * Generic method to delete an object based on class and id
     *
     * @param id the identifier (primary key) of the object to remove
     */
    long delete(PK id);

}
