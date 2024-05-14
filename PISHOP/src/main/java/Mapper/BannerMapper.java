package Mapper;

import Mapper.IMapper.ROWMapper;
import Model.BannerModel;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BannerMapper implements ROWMapper<BannerModel> {
    @Override
    public BannerModel mapRow(ResultSet resultSet) {
        try{
            BannerModel bannerModel = new BannerModel();
            bannerModel.setId(resultSet.getInt("bannerID"));
            bannerModel.setBannerLink(resultSet.getString("bannerLink"));
            bannerModel.setCreatedBy(resultSet.getString("createBy"));
            bannerModel.setCreatedDate(resultSet.getTimestamp("createdDate"));
            if (resultSet.getTimestamp("modifiedDate") != null) {
                bannerModel.setModifiedDate(resultSet.getTimestamp("modifiedDate"));
            }
            if (resultSet.getString("modifiedBy") != null) {
                bannerModel.setModifiedBy(resultSet.getString("modifiedBy"));
            }
            return bannerModel;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
