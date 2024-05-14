package Model;

public class CartProductModel extends AbstractsModel<CartProductModel> {

    private Integer cartID;

    private Integer productID;

    private Integer quantity;

    private double price;

    private Integer ColorID;

    private Integer capacityID;

    private Integer status;

    private Integer userID;

    public Integer getCartID() {
        return cartID;
    }

    public void setCartID(Integer cartID) {
        this.cartID = cartID;
    }

    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Integer getColorID() {
        return ColorID;
    }

    public void setColorID(Integer colorID) {
        ColorID = colorID;
    }

    public Integer getCapacityID() {
        return capacityID;
    }

    public void setCapacityID(Integer capacityID) {
        this.capacityID = capacityID;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }
}
