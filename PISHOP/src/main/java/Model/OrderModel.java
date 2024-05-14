package Model;

public class OrderModel extends AbstractsModel<OrderModel> {

    private Integer userID;
    private Integer productID;
    private Integer quantity;
    private double price;
    private Integer status;
    private Integer cartProductID;

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getCartProductID() {
        return cartProductID;
    }

    public void setCartProductID(Integer cartProductID) {
        this.cartProductID = cartProductID;
    }
}
