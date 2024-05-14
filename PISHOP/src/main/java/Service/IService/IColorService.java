package Service.IService;

import Model.ColorModel;


import java.util.List;

public interface IColorService {

    List<ColorModel> findAll();

    List<ColorModel> findByProductID(Integer id);

    Integer save(ColorModel saveRColor);

    void update(ColorModel updateColor);

    void delete(Integer[] id);

    int countItem();

    void insertProductColors(Integer productID, Integer[] colorID);

    boolean checkProductColor(Integer productID, Integer colorID);

    void deleteProductColor(Integer productID, Integer[] colorID);

    void deleteProductColors(Integer[] productID);

    boolean checkExist(String colorCode);

}
