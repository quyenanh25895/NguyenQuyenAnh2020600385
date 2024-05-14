package Service.IService;

import Model.BannerModel;
import paging.IPageble;

import java.util.List;

public interface IBannerService {

    List<BannerModel> findAll(IPageble pageble);
}
