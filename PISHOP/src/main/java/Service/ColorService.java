package Service;

import DAO.IDAO.IColorDAO;
import Model.ColorModel;
import Service.IService.IColorService;

import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

public class ColorService implements IColorService {

    @Inject
    private IColorDAO colorDAO;

    @Override
    public List<ColorModel> findAll() {
        return colorDAO.findAll();
    }

    @Override
    public List<ColorModel> findByProductID(Integer id) {
        return colorDAO.findByProductID(id);
    }

    @Override
    public Integer save(ColorModel saveRColor) {
        return colorDAO.save(saveRColor);
    }

    @Override
    public void update(ColorModel updateColor) {
        colorDAO.update(updateColor);
    }

    @Override
    public void delete(Integer[] id) {
        for (Integer i : id) {
            colorDAO.delete(i);
        }
    }

    @Override
    public int countItem() {
        return 0;
    }

    @Override
    public void insertProductColors(Integer productID, Integer[] colorID) {
        List<ColorModel> oldColor = colorDAO.findByProductID(productID);
        List<Integer> oldColorID = new ArrayList<>();
        for (ColorModel color : oldColor) {
            oldColorID.add(color.getId());
        }
        if(colorID != null){
            for (Integer id : colorID) {
                oldColorID.remove(id);
            }
        }
        Integer[] oldColorIDs = oldColorID.toArray(new Integer[oldColorID.size()]);
        deleteProductColor(productID, oldColorIDs);

        for (Integer integer : colorID) {
            if (checkProductColor(productID, integer)) {
                colorDAO.insertProductColors(productID, integer);
            }
        }
    }

    public static void main(String[] args) {
        IColorService colorService = new ColorService();
        List<ColorModel> colorModels = colorService.findAll();
        for (ColorModel colorModel : colorModels) {
            System.out.println(colorModel);
        }
        colorService.insertProductColors(3, new Integer[]{1, 2, 3, 4});
    }

    @Override
    public boolean checkProductColor(Integer prductID, Integer colorID) {
        return colorDAO.checkProductColor(prductID, colorID);
    }

    @Override
    public void deleteProductColor(Integer productID, Integer[] colorID) {
        for (Integer i : colorID){{
            colorDAO.deleteProductColors(productID, i);
        }}
    }

    @Override
    public void deleteProductColors(Integer[] productID) {
        for (Integer id : productID) {
            colorDAO.delete(id);
        }
    }

    @Override
    public boolean checkExist(String colorCode) {
        return colorDAO.checkExit(colorCode);
    }

}
