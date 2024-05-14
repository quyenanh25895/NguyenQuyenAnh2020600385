package DAO.IDAO;

import Model.ColorModel;

import java.util.List;

public interface IColorDAO extends IGenericDAO<ColorModel> {

    List<ColorModel> findAll();

    Integer save(ColorModel saveColor);

    ColorModel findOne(int id);

    void update(ColorModel updateColor);

    void delete(int id);

    Integer getTotalItem();

    boolean checkProductColor(Integer productId, Integer colorId);

    List<ColorModel> findByProductID(Integer productID);

    void insertProductColors(Integer productID, Integer colorID);

    void deleteProductColors(Integer productID, Integer colorID);

    boolean checkExit(String colorCode);
}
