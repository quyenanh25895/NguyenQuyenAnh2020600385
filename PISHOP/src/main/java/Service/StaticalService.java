package Service;

import DAO.IDAO.IStaticalDAO;
import Model.StaticalModel;
import Service.IService.IStaticalService;
import paging.PageRequest;

import javax.inject.Inject;
import java.util.List;

public class StaticalService implements IStaticalService {

    @Inject
    private IStaticalDAO staticalDAO;

    @Override
    public List<StaticalModel> countOrder(PageRequest pageble) {
        return staticalDAO.countOrder(pageble);
    }

    @Override
    public List<StaticalModel> getPriceByUserID() {
        return staticalDAO.getPriceByUserID();
    }

    @Override
    public List<StaticalModel> getTop10Product() {
        return staticalDAO.getTop10Product();
    }
}
