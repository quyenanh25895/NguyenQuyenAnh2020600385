package DAO;

import DAO.IDAO.ICouponDAO;
import Mapper.CouponMapper;
import Model.CouponModel;

import java.util.List;

public class CouponDAO extends AbstractDAO<CouponModel> implements ICouponDAO {
    @Override
    public List<CouponModel> findAll() {
        String sql = "SELECT * FROM coupons";
        return query(sql, new CouponMapper());
    }

    @Override
    public CouponModel findByCouponCode(String couponCode) {
        String sql = "SELECT * FROM coupons WHERE code = ?";
        List<CouponModel> list = query(sql, new CouponMapper(), couponCode);
        if (list.isEmpty()) {
            return null;
        }
        return list.get(0);
    }

    @Override
    public void updateCoupon(String code) {
        String sql = "UPDATE coupons SET quantity = ? WHERE code = ?";
        update(sql, code);
    }
}
