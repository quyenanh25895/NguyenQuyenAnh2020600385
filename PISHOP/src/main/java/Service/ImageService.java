package Service;

import DAO.IDAO.IImageDAO;
import Model.ImageModel;
import Model.ProductModel;
import Model.UserModel;
import Service.IService.IImageService;

import javax.inject.Inject;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

public class ImageService implements IImageService {

    @Inject
    private IImageDAO imageDAO;

    @Override
    public List<ImageModel> findAll() {
        return imageDAO.findAll();
    }

    @Override
    public List<ImageModel> findByProductId(int id) {
        return imageDAO.findByProductID(id);
    }

    @Override
    public void save(ProductModel productModel, UserModel userModel) {
        for (String i : productModel.getImagePaths()) {
            ImageModel imageModel = new ImageModel();
            imageModel.setProductID(productModel.getId());
            imageModel.setProductName(productModel.getName());
            imageModel.setImageLink(i);
            imageModel.setCreatedBy(userModel.getUserName());
            imageModel.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            imageModel.setModifiedBy(userModel.getUserName());
            imageModel.setModifiedDate(new Timestamp(System.currentTimeMillis()));
            imageDAO.save(imageModel);
        }
    }

    @Override
    public void update(ProductModel productModel, UserModel userModel) {
        List<ImageModel> oldImageModels = imageDAO.findByProductID(productModel.getId());
        List<ImageModel> imageModels = new ArrayList<>();

        List<String> imageLinks = new ArrayList<>();
        Collections.addAll(imageLinks, productModel.getImagePaths());

        List<Integer> imageID = new ArrayList<>();
        Collections.addAll(imageID, productModel.getIds());
        int size = imageLinks.size();
        if (size > imageID.size()) {
            if (!imageLinks.get(size - 1).isEmpty() && !imageLinks.get(size - 1).isBlank()) {
                ImageModel imageModel = new ImageModel();
                imageModel.setProductID(productModel.getId());
                imageModel.setProductName(productModel.getName());
                imageModel.setImageLink(imageLinks.get(size - 1));
                imageModel.setCreatedBy(userModel.getUserName());
                imageModel.setCreatedDate(new Timestamp(System.currentTimeMillis()));
                imageModel.setModifiedBy(userModel.getUserName());
                imageModel.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                imageDAO.save(imageModel);
            } else {
                for (int i = 0; i < imageID.size(); i++) {
                    ImageModel imageModel = new ImageModel();
                    imageModel.setId(imageID.get(i));
                    imageModel.setProductID(productModel.getId());
                    imageModel.setProductName(productModel.getName());
                    imageModel.setImageLink(imageLinks.get(i));
                    imageModel.setModifiedBy(userModel.getUserName());
                    imageModel.setModifiedDate(new Timestamp(System.currentTimeMillis()));
                    imageModels.add(imageModel);
                }

                for (ImageModel oldModel : oldImageModels) {
                    for (ImageModel newModel : imageModels) {
                        if (Objects.equals(newModel.getId(), oldModel.getId())) {
                            imageDAO.update(newModel);
                        }
                    }
                }
            }
        }
    }

    @Override
    public void delete(Integer id) {

    }


}
