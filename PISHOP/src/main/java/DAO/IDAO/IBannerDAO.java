package DAO.IDAO;

import Model.BannerModel;
import paging.IPageble;

import java.util.List;

public interface IBannerDAO extends IGenericDAO<BannerModel> {

    List<BannerModel> findAll(IPageble pageble);

}
