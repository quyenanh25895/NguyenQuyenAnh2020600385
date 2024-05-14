package Model;

public class ProductImageModel extends AbstractsModel<ProductImageModel> {

    private Integer productID;
    private Integer imageID;


    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public Integer getImageID() {
        return imageID;
    }

    public void setImageID(Integer imageID) {
        this.imageID = imageID;
    }
}
