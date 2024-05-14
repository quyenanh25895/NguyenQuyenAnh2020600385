package Model;

public class BannerModel extends AbstractsModel<BannerModel> {

    private String bannerLink;
    private Integer status;

    public String getBannerLink() {
        return bannerLink;
    }

    public void setBannerLink(String bannerLink) {
        this.bannerLink = bannerLink;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
