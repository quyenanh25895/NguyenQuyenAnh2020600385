package Service;

import DAO.IDAO.IBrandDAO;
import Model.BrandModel;
import Service.IService.IBrandService;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

public class BrandService implements IBrandService {

    @Inject
    private IBrandDAO brandDAO;

    @Override
    public List<BrandModel> findAll() {
        return brandDAO.findAll();
    }

    @Override
    public Integer save(BrandModel saveBrand) {
        return brandDAO.save(saveBrand);
    }

    @Override
    public BrandModel findOne(int id) {
        return brandDAO.findOne(id);
    }

    @Override
    public List<BrandModel> findByBrandID(List<Integer> brandID) {
        List<BrandModel> brandModels = new ArrayList<>();
        for (Integer id : brandID) {
            brandModels.add(brandDAO.findOne(id));
        }
        return brandModels;
    }

    @Override
    public void update(BrandModel updateBrand) {
        brandDAO.update(updateBrand);
    }

    @Override
    public void delete(int id) {

    }

    @Override
    public Integer getTotalItem() {
        return 0;
    }

    @Override
    public boolean checkExist(String brandName) {
        return brandDAO.checkExist(brandName);
    }
}
