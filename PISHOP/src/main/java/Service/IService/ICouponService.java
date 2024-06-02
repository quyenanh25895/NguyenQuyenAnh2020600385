package Service.IService;

import Model.CouponModel;

import java.util.List;

public interface ICouponService {

    List<CouponModel> findAll();

    CouponModel findByCode(String code);
}
