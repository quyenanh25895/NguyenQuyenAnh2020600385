package Model;

public class ProductCapacityModel extends AbstractsModel<ProductCapacityModel> {
    private Integer productID;
    private Integer capacityID;

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public Integer getCapacityID() {
        return capacityID;
    }

    public void setCapacityID(Integer capacityID) {
        this.capacityID = capacityID;
    }
}
