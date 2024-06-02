package DAO.IDAO;

import Model.CouponModel;

import java.util.List;

public interface ICouponDAO extends IGenericDAO<CouponModel> {
    List<CouponModel> findAll();

    CouponModel findByCouponCode(String couponCode);

    void updateCoupon(String code);
}
