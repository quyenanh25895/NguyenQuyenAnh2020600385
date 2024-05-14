package Model;

public class CategoryModel extends AbstractsModel<CategoryModel> {

    private String cateName;
    private int cateStatus;

    public CategoryModel(){

    }

    public CategoryModel(String cateName, int cateStatus) {
        this.cateName = cateName;
        this.cateStatus = cateStatus;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    public int getCateStatus() {
        return cateStatus;
    }

    public void setCateStatus(int cateStatus) {
        this.cateStatus = cateStatus;
    }
}
