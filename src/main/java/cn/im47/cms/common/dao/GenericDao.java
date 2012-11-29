package cn.im47.cms.common.dao;

import org.apache.ibatis.annotations.Param;
import org.joda.time.DateTime;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * Generic DAO (Data Access Object) with common methods to CRUD POJOs.
 * <p/>
 * <p>Extend this interface if you want typesafe (no casting necessary) DAO's for your
 * domain objects.
 *
 * @param <T>  a type variable
 * @param <PK> the primary key for that type
 * @author baitao.jibt@gmail.com
 * @version 1.0
 * @since 2010-04-17
 */
public interface GenericDao<T, PK extends Serializable> {

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
     * 返回实体个数
     *
     * @return 记录数
     */
    long count();

    /**
     * Generic method to save an object - handles insert.  will set modified_time to
     * current time and will set created_time to current_system_time if it's an insert.
     *
     * @param object the object to save
     * @return the persisted object
     */
    long save(T object);

    /**
     * 更新实体
     *
     * @param object the object to save
     * @return the persisted object
     */
    long update(T object);

    /**
     * 更新bool字段
     *
     * @param id     the object to save
     * @param column the object to save
     * @return the persisted object
     */
    long updateBool(@Param("id") Long id, @Param("column") String column);

    void updateTimeToNow(@Param("id") Long id, @Param("column") String column, @Param("now") DateTime now);

    /**
     * Generic method to delete an object based on class and id
     *
     * @param id the identifier (primary key) of the object to remove
     */
    long delete(PK id);

    /**
     * Generic method used to get all objects of a particular type. This
     * is the same as lookup up all rows in a table.
     *
     * @return List of populated objects
     */
    List<T> search(Map<String, Object> parameters);

}
