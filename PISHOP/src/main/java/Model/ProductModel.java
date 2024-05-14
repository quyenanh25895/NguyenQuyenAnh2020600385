package Model;

public class ProductModel extends AbstractsModel<ProductModel> {

    private String name;
    private double price;
    private Integer quantity;
    private int brandID;
    private String brandName;
    private Integer cateID;
    private String cateName;
    private String description;
    private int status;
    private String[] imagePaths;
    private Integer[] colorIDs;
    private Integer[] capacityIDs;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public int getBrandID() {
        return brandID;
    }

    public void setBrandID(int brandID) {
        this.brandID = brandID;
    }

    public Integer getCateID() {
        return cateID;
    }

    public void setCateID(Integer cateID) {
        this.cateID = cateID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String[] getImagePaths() {
        return imagePaths;
    }

    public void setImagePaths(String[] imagePaths) {
        this.imagePaths = imagePaths;
    }

    public Integer[] getColorIDs() {
        return colorIDs;
    }

    public void setColorIDs(Integer[] colorIDs) {
        this.colorIDs = colorIDs;
    }

    public Integer[] getCapacityIDs() {
        return capacityIDs;
    }

    public void setCapacityIDs(Integer[] capacityIDs) {
        this.capacityIDs = capacityIDs;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }
}
