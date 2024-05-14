package Service;

import DAO.IDAO.IBannerDAO;
import Model.BannerModel;
import Service.IService.IBannerService;
import paging.IPageble;

import javax.inject.Inject;
import java.util.List;

public class BannerService implements IBannerService {

    @Inject
    private IBannerDAO bannerDAO;

    @Override
    public List<BannerModel> findAll(IPageble pageble) {
        return bannerDAO.findAll(pageble);
    }
}
