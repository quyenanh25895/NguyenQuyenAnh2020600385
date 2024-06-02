package Model;

public class CouponModel extends AbstractsModel<CouponModel> {

    private String code;
    private Integer quantity;
    private Integer discount;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    @Override
    public Integer getDiscount() {
        return discount;
    }

    @Override
    public void setDiscount(Integer discount) {
        this.discount = discount;
    }
}
