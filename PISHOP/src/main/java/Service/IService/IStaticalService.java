package Service.IService;

import Model.StaticalModel;
import paging.PageRequest;

import java.util.List;

public interface IStaticalService {
    List<StaticalModel> countOrder(PageRequest pageble);

    List<StaticalModel> getPriceByUserID();

    List<StaticalModel> getTop10Product();
}
