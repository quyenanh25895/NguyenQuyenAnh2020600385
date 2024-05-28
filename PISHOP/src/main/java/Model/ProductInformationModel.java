package Model;

public class ProductInformationModel extends AbstractsModel<ProductInformationModel> {

    private Integer productID;
    private Integer timeManufacture;
    private String country;
    private Integer pinValue;
    private Long display;
    private String resolution;
    private String chipset;


    public Integer getProductID() {
        return productID;
    }

    public void setProductID(Integer productID) {
        this.productID = productID;
    }

    public Integer getTimeManufacture() {
        return timeManufacture;
    }

    public void setTimeManufacture(Integer timeManufacture) {
        this.timeManufacture = timeManufacture;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Integer getPinValue() {
        return pinValue;
    }

    public void setPinValue(Integer pinValue) {
        this.pinValue = pinValue;
    }

    public Long getDisplay() {
        return display;
    }

    public void setDisplay(Long display) {
        this.display = display;
    }

    public String getResolution() {
        return resolution;
    }

    public void setResolution(String resolution) {
        this.resolution = resolution;
    }

    public String getChipset() {
        return chipset;
    }

    public void setChipset(String chipset) {
        this.chipset = chipset;
    }
}
