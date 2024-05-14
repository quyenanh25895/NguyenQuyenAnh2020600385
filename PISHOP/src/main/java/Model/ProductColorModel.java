package Model;

public class ProductColorModel extends AbstractsModel<ProductColorModel> {

    private Integer productID;
    private Integer colorID;

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public Integer getColorID() {
        return colorID;
    }

    public void setColorID(Integer colorID) {
        this.colorID = colorID;
    }
}
