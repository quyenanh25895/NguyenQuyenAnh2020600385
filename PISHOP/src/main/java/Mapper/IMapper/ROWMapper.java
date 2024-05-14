package Mapper.IMapper;

import java.sql.ResultSet;

public interface ROWMapper<T> {
    T mapRow(ResultSet resultSet);
}
