package DAO.IDAO;

import Model.CapacityModel;

import java.util.List;

public interface ICapcityDAO extends IGenericDAO<CapacityModel> {

    List<CapacityModel> findAll();

    boolean checkProductCapacity(Integer productId, Integer capacityID);

    List<CapacityModel> findByProductID(Integer productID);

    void insertProductCapacity(Integer productID, Integer capacityID);

    Integer save(CapacityModel saveCapacity);

    CapacityModel findOne(int id);

    void update(CapacityModel updateCapacity);

    void delete(int id);

    Integer getTotalItem();

    void deleteProductCapacity(Integer productID, Integer capacityID);

    boolean checkExit(Long capacityValue);
}
