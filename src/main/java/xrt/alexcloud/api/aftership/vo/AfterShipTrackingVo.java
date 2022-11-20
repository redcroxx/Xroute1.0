package xrt.alexcloud.api.aftership.vo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class AfterShipTrackingVo implements Serializable {

    private static final long serialVersionUID = 1L;

    private String slug;
    private String trackingNumber;
    private String title;
    private List<String> emails;
    private String orderId;
    private String orderIdPath;
    private Map<String, Object> customFields;
    private String language;
    private String orderPromisedDeliveryDate;
    private String deliveryType;
    private String pickupLocation;
    private String pickupNote;

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<String> getEmails() {
        return emails;
    }

    public void setEmails(List<String> emails) {
        this.emails = emails;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getOrderIdPath() {
        return orderIdPath;
    }

    public void setOrderIdPath(String orderIdPath) {
        this.orderIdPath = orderIdPath;
    }

    public Map<String, Object> getCustomFields() {
        return customFields;
    }

    public void setCustomFields(Map<String, Object> customFields) {
        this.customFields = customFields;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getOrderPromisedDeliveryDate() {
        return orderPromisedDeliveryDate;
    }

    public void setOrderPromisedDeliveryDate(String orderPromisedDeliveryDate) {
        this.orderPromisedDeliveryDate = orderPromisedDeliveryDate;
    }

    public String getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getPickupNote() {
        return pickupNote;
    }

    public void setPickupNote(String pickupNote) {
        this.pickupNote = pickupNote;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append(getClass().getName());
        builder.append(" {\n\tslug: ");
        builder.append(slug);
        builder.append("\n\ttrackingNumber: ");
        builder.append(trackingNumber);
        builder.append("\n\ttitle: ");
        builder.append(title);
        builder.append("\n\temails: ");
        builder.append(emails);
        builder.append("\n\torderId: ");
        builder.append(orderId);
        builder.append("\n\torderIdPath: ");
        builder.append(orderIdPath);
        builder.append("\n\tcustomFields: ");
        builder.append(customFields);
        builder.append("\n\tlanguage: ");
        builder.append(language);
        builder.append("\n\torderPromisedDeliveryDate: ");
        builder.append(orderPromisedDeliveryDate);
        builder.append("\n\tdeliveryType: ");
        builder.append(deliveryType);
        builder.append("\n\tpickupLocation: ");
        builder.append(pickupLocation);
        builder.append("\n\tpickupNote: ");
        builder.append(pickupNote);
        builder.append("\n}");
        return builder.toString();
    }
}
