package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.CouponModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CouponMapper implements ROWMapper<CouponModel> {

    @Override
    public CouponModel mapRow(ResultSet resultSet) {
        try {
            CouponModel couponModel = new CouponModel();
            couponModel.setId(resultSet.getInt("couponID"));
            couponModel.setCode(resultSet.getString("code"));
            couponModel.setQuantity(resultSet.getInt("quantity"));
            couponModel.setDiscount(resultSet.getInt("discount"));
            return couponModel;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
