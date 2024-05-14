package Service;

import DAO.IDAO.ICapcityDAO;
import Model.CapacityModel;
import Service.IService.ICapacityService;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

public class CapacityService implements ICapacityService {

    @Inject
    private ICapcityDAO capcityDAO;

    @Override
    public List<CapacityModel> findAll() {
        return capcityDAO.findAll();
    }

    @Override
    public Integer save(CapacityModel saveCapacity) {
        return capcityDAO.save(saveCapacity);
    }

    @Override
    public CapacityModel findOne(int id) {
        return null;
    }

    @Override
    public void update(CapacityModel updateCapacity) {
        capcityDAO.update(updateCapacity);
    }

    @Override
    public void delete(Integer[] id) {
        for (Integer i : id) {
            capcityDAO.delete(i);
        }
    }

    @Override
    public Integer getTotalItem() {
        return 0;
    }

    @Override
    public List<CapacityModel> findByProductID(Integer id) {
        return capcityDAO.findByProductID(id);
    }

    @Override
    public void insertProductCapacity(Integer productID, Integer[] capacityID) {
        List<CapacityModel> oldCapacity = capcityDAO.findByProductID(productID);
        List<Integer> oldCapacityID = new ArrayList<>();

        for (CapacityModel color : oldCapacity) {
            oldCapacityID.add(color.getId());
        }
        for (Integer id : capacityID) {
            if (oldCapacityID.contains(id)) {
                oldCapacityID.remove(id);
            }
        }
        Integer[] oldCapacityIDs = oldCapacityID.toArray(new Integer[oldCapacityID.size()]);
        deleteProductCapacity(productID, oldCapacityIDs);

        for (Integer integer : capacityID) {
            if (checkProductCapacity(productID, integer)) {
                capcityDAO.insertProductCapacity(productID, integer);
            }
        }
    }

    @Override
    public boolean checkProductCapacity(Integer productID, Integer capacityID) {
        return capcityDAO.checkProductCapacity(productID, capacityID);
    }

    @Override
    public void deleteProductCapacity(Integer productID, Integer[] capacityID) {
        for (Integer i : capacityID) {
            capcityDAO.deleteProductCapacity(productID, i);
        }
    }

    @Override
    public void deleteAllProductCapacities(Integer[] productID) {
        for (Integer i : productID) {
            capcityDAO.delete(i);
        }
    }

    @Override
    public boolean checkExist(Long capacityValue) {
        return capcityDAO.checkExit(capacityValue);
    }
}
