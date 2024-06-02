package Service;

import DAO.IDAO.ICouponDAO;
import Model.CouponModel;
import Service.IService.ICouponService;

import javax.inject.Inject;
import java.util.List;

public class CouponService implements ICouponService {

    @Inject
    private ICouponDAO couponDAO;

    @Override
    public List<CouponModel> findAll() {
        return couponDAO.findAll();
    }

    @Override
    public CouponModel findByCode(String code) {
        return couponDAO.findByCouponCode(code);
    }
}
