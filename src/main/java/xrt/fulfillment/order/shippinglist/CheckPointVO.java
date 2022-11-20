package xrt.fulfillment.order.shippinglist;

import java.io.Serializable;
import java.util.List;

public class CheckPointVO implements Serializable{

    private static final long serialVersionUID = 1L;
    
    private String slug;
    private String city;
    private String created_at;
    private String location;
    private String country_name;
    private String message;
    private String country_iso3;
    private String tag;
    private String subtag;
    private String subtag_message;
    private String checkpoint_time;
    private List coordinates;
    private String state;
    private String zip;
    private String raw_tag;
    
    public String getSlug() {
        return slug;
    }
    public void setSlug(String slug) {
        this.slug = slug;
    }
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }
    public String getCreated_at() {
        return created_at;
    }
    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public String getCountry_name() {
        return country_name;
    }
    public void setCountry_name(String country_name) {
        this.country_name = country_name;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public String getCountry_iso3() {
        return country_iso3;
    }
    public void setCountry_iso3(String country_iso3) {
        this.country_iso3 = country_iso3;
    }
    public String getTag() {
        return tag;
    }
    public void setTag(String tag) {
        this.tag = tag;
    }
    public String getSubtag() {
        return subtag;
    }
    public void setSubtag(String subtag) {
        this.subtag = subtag;
    }
    public String getSubtag_message() {
        return subtag_message;
    }
    public void setSubtag_message(String subtag_message) {
        this.subtag_message = subtag_message;
    }
    public String getCheckpoint_time() {
        return checkpoint_time;
    }
    public void setCheckpoint_time(String checkpoint_time) {
        this.checkpoint_time = checkpoint_time;
    }
    public List getCoordinates() {
        return coordinates;
    }
    public void setCoordinates(List coordinates) {
        this.coordinates = coordinates;
    }
    public String getState() {
        return state;
    }
    public void setState(String state) {
        this.state = state;
    }
    public String getZip() {
        return zip;
    }
    public void setZip(String zip) {
        this.zip = zip;
    }
    public String getRaw_tag() {
        return raw_tag;
    }
    public void setRaw_tag(String raw_tag) {
        this.raw_tag = raw_tag;
    }
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("CheckPointVO {\n    slug : ");
        builder.append(slug);
        builder.append(",\n    city : ");
        builder.append(city);
        builder.append(",\n    created_at : ");
        builder.append(created_at);
        builder.append(",\n    location : ");
        builder.append(location);
        builder.append(",\n    country_name : ");
        builder.append(country_name);
        builder.append(",\n    message : ");
        builder.append(message);
        builder.append(",\n    country_iso3 : ");
        builder.append(country_iso3);
        builder.append(",\n    tag : ");
        builder.append(tag);
        builder.append(",\n    subtag : ");
        builder.append(subtag);
        builder.append(",\n    subtag_message : ");
        builder.append(subtag_message);
        builder.append(",\n    checkpoint_time : ");
        builder.append(checkpoint_time);
        builder.append(",\n    coordinates : ");
        builder.append(coordinates);
        builder.append(",\n    state : ");
        builder.append(state);
        builder.append(",\n    zip : ");
        builder.append(zip);
        builder.append(",\n    raw_tag : ");
        builder.append(raw_tag);
        builder.append("\n}");
        return builder.toString();
    }
}
