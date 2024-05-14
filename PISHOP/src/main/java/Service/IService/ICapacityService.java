package Service.IService;

import Model.CapacityModel;

import java.util.List;

public interface ICapacityService {

    List<CapacityModel> findAll();

    Integer save(CapacityModel saveCapacity);

    CapacityModel findOne(int id);

    void update(CapacityModel updateCapacity);

    void delete(Integer[] id);

    Integer getTotalItem();

    List<CapacityModel> findByProductID(Integer id);

    void insertProductCapacity(Integer productID, Integer[] capacityID);

    boolean checkProductCapacity(Integer productID, Integer capacityID);

    void deleteProductCapacity(Integer productID, Integer[] capacityID);

    void deleteAllProductCapacities(Integer[] productID);

    boolean checkExist(Long capacityValue);
}
