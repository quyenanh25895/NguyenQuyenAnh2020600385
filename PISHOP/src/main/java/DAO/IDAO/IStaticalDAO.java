package DAO.IDAO;

import Model.StaticalModel;
import paging.IPageble;

import java.util.List;
import java.util.stream.LongStream;

public interface IStaticalDAO extends IGenericDAO<StaticalModel> {
    List<StaticalModel> countOrder(IPageble pageble);

    List<StaticalModel> getPriceByUserID();

    List<StaticalModel> getTop10Product();
}
