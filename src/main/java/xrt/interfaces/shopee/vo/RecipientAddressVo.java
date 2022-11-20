package xrt.interfaces.shopee.vo;

import java.io.Serializable;

public class RecipientAddressVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String town;
    private String city;
    private String name;
    private String district;
    private String country;
    private String zipcode;
    private String fullAddress;
    private String phone;
    private String state;

    public String getTown() {
        return town;
    }

    public void setTown(String town) {
        this.town = town;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\ttown: ");
        builder.append(town);
        builder.append("\n\tcity: ");
        builder.append(city);
        builder.append("\n\tname: ");
        builder.append(name);
        builder.append("\n\tdistrict: ");
        builder.append(district);
        builder.append("\n\tcountry: ");
        builder.append(country);
        builder.append("\n\tzipcode: ");
        builder.append(zipcode);
        builder.append("\n\tfullAddress: ");
        builder.append(fullAddress);
        builder.append("\n\tphone: ");
        builder.append(phone);
        builder.append("\n\tstate: ");
        builder.append(state);
        builder.append("\n}");
        return builder.toString();
    }
}
