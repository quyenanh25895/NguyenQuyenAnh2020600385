package DAO.IDAO;

import Mapper.IMapper.ROWMapper;

import java.util.List;

public interface IGenericDAO<T> {
    <T> List<T> query(String sql, ROWMapper<T> rowMapper, Object... parameters);

    void update(String sql, Object... parameters);

    void delete(String sql, Object... parameters);

    Integer insert(String sql, Object... parameters);

    int count(String sql, Object... parameters);
}

