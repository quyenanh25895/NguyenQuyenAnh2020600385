package DAO;

import DAO.IDAO.IBannerDAO;
import Mapper.BannerMapper;
import Model.BannerModel;
import org.apache.commons.lang.StringUtils;
import paging.IPageble;

import java.util.List;

public class BannerDAO extends AbstractDAO<BannerModel> implements IBannerDAO {
    @Override
    public List<BannerModel> findAll(IPageble pageble) {
        StringBuilder sql = new StringBuilder();
        sql.append("select * from banners");
        if (pageble.getSorter() != null && StringUtils.isNotBlank(pageble.getSorter().getSortName()) && StringUtils.isNotBlank(pageble.getSorter().getSortBy())) {
            sql.append(" ORDER BY " + pageble.getSorter().getSortName() + " " + pageble.getSorter().getSortBy() + "");
        }
        if (pageble.getOffset() != null && pageble.getLimit() != null) {
            sql.append(" LIMIT " + pageble.getOffset() + ", " + pageble.getLimit() + "");
        }
        return query(sql.toString(), new BannerMapper());
    }
}
