package Service.IService;

import Model.BrandModel;

import java.util.List;

public interface IBrandService {

    List<BrandModel> findAll();

    Integer save(BrandModel saveBrand);

    BrandModel findOne(int id);

    List<BrandModel> findByBrandID(List<Integer> brandID);

    void update(BrandModel updateBrand);

    void delete(int id);

    Integer getTotalItem();

    boolean checkExist(String brandName);
}
