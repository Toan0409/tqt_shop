package vn.java.laptopshop.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Tên sản phẩm không được để trống")
    @Size(max = 255, message = "Tên sản phẩm không được dài quá 255 ký tự")
    private String name;

    @NotNull(message = "Giá không được để trống")
    @DecimalMin(value = "0.0", inclusive = false, message = "Giá phải lớn hơn 0")
    private Double price;

    @NotBlank(message = "Ảnh không được để trống")
    private String image;

    @Column(columnDefinition = "MEDIUMTEXT")
    @Size(max = 2000, message = "Mô tả chi tiết không được dài quá 2000 ký tự")
    private String detailDesc;

    @Size(max = 500, message = "Mô tả ngắn không được dài quá 500 ký tự")
    private String shortDesc;

    @Min(value = 0, message = "Số lượng đã bán không được âm")
    private long sold;

    @Min(value = 0, message = "Số lượng tồn kho không được âm")
    private long quantity;

    @NotBlank(message = "Hãng sản xuất không được để trống")
    private String factory;

    private String target;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public long getSold() {
        return sold;
    }

    public void setSold(long sold) {
        this.sold = sold;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    @Override
    public String toString() {
        return "Product [id=" + id + ", name=" + name + ", price=" + price + ", image=" + image + ", detailDesc="
                + detailDesc + ", shortDesc=" + shortDesc + ", sold=" + sold + ", quantity=" + quantity + ", factory="
                + factory + ", target=" + target + "]";
    }

}

// dữ liệu
// INSERT INTO

// products (id, detail_desc, factory, image, name, price, quantity,
// short_desc, sold, target) VALUES
// (1, 'Laptop Dell Inspiron 15 với chip Intel i5 thế hệ 12, RAM 8GB, SSD
// 512GB.', 'Dell', 'dell-inspiron.jpg', 'Laptop Dell Inspiron 15', 15000000,
// 50, 'Laptop văn phòng giá rẻ', 120, 'Sinh viên'),
// (2, 'HP Pavilion 14 nhỏ gọn, chip Intel i5, RAM 8GB, thiết kế sang trọng.',
// 'HP', 'hp-pavilion.jpg', 'Laptop HP Pavilion 14', 17000000, 40, 'Laptop học
// tập và làm việc', 95, 'Học sinh'),
// (3, 'Laptop gaming với chip Intel i7, RTX 3050, RAM 16GB.', 'Asus',
// 'asus-tuf.jpg', 'Laptop Asus TUF Gaming F15', 25000000, 30, 'Laptop gaming
// tầm trung', 210, 'Game thủ'),
// (4, 'Laptop doanh nhân cao cấp, mỏng nhẹ, hiệu năng mạnh mẽ.', 'Lenovo',
// 'thinkpad-x1.jpg', 'Laptop Lenovo ThinkPad X1 Carbon', 32000000, 20, 'Laptop
// doanh nhân', 80, 'Doanh nhân'),
// (5, 'MacBook Air M2 mới, pin trâu, màn Retina.', 'Apple',
// 'macbook-air-m2.jpg', 'MacBook Air M2', 28000000, 25, 'MacBook mới nhất',
// 300, 'Người đi làm'),
// (6, 'iPhone 14 Pro Max với chip A16 Bionic, màn hình ProMotion 120Hz.',
// 'Apple', 'iphone-14-pro.jpg', 'iPhone 14 Pro Max', 33000000, 60, 'Flagship
// Apple 2023', 500, 'Người dùng cao cấp'),
// (7, 'Galaxy S23 Ultra với camera 200MP, Snapdragon 8 Gen 2.', 'Samsung',
// 's23-ultra.jpg', 'Samsung Galaxy S23 Ultra', 31000000, 45, 'Flagship Samsung
// 2023', 420, 'Người dùng cao cấp'),
// (8, 'Điện thoại tầm trung giá rẻ, pin 5000mAh.', 'Xiaomi',
// 'redmi-note-12.jpg', 'Xiaomi Redmi Note 12', 6000000, 70, 'Điện thoại phổ
// thông', 350, 'Sinh viên'),
// (9, 'OPPO Reno 10 thiết kế đẹp, camera chân dung AI.', 'Oppo',
// 'oppo-reno-10.jpg', 'OPPO Reno 10', 11000000, 55, 'Điện thoại chụp ảnh đẹp',
// 180, 'Giới trẻ'),
// (10, 'Vivo V27e với camera OIS, pin bền.', 'Vivo', 'vivo-v27e.jpg', 'Vivo
// V27e', 9000000, 50, 'Điện thoại selfie đẹp', 150, 'Nữ giới'),
// (11, 'iPad Air 5 chip M1 mạnh mẽ, hỗ trợ Apple Pencil 2.', 'Apple',
// 'ipad-air-5.jpg', 'iPad Air 5', 17000000, 35, 'Máy tính bảng mạnh mẽ', 210,
// 'Sinh viên'),
// (12, 'Galaxy Tab S9 màn AMOLED 12.4 inch, bút S Pen.', 'Samsung',
// 'tab-s9.jpg', 'Samsung Galaxy Tab S9', 23000000, 20, 'Tablet cao cấp
// Android', 180, 'Người đi làm'),
// (13, 'Xiaomi Pad 6 giá rẻ, cấu hình mạnh.', 'Xiaomi', 'xiaomi-pad-6.jpg',
// 'Xiaomi Pad 6', 9000000, 40, 'Tablet giải trí', 160, 'Học sinh'),
// (14, 'Tablet Lenovo P11 Pro màn OLED, pin 8600mAh.', 'Lenovo',
// 'lenovo-p11.jpg', 'Lenovo Tab P11 Pro', 12000000, 25, 'Tablet văn phòng', 90,
// 'Người đi làm'),
// (15, 'Tai nghe chống ồn chủ động, Spatial Audio.', 'Apple',
// 'airpods-pro-2.jpg', 'Tai nghe AirPods Pro 2', 6500000, 80, 'Tai nghe Apple
// cao cấp', 300, 'Người dùng iPhone'),
// (16, 'Tai nghe chụp tai chống ồn tốt nhất hiện nay.', 'Sony', 'sony-xm5.jpg',
// 'Tai nghe Sony WH-1000XM5', 9000000, 35, 'Tai nghe chống ồn cao cấp', 200,
// 'Dân văn phòng'),
// (17, 'Chuột văn phòng cao cấp, pin lâu, hỗ trợ nhiều thiết bị.', 'Logitech',
// 'logitech-mx3s.jpg', 'Chuột Logitech MX Master 3S', 2500000, 40, 'Chuột văn
// phòng', 150, 'Người đi làm'),
// (18, 'Bàn phím cơ không dây, hỗ trợ nhiều thiết bị.', 'Keychron',
// 'keychron-k6.jpg', 'Bàn phím Keychron K6', 2800000, 25, 'Bàn phím cơ mini',
// 120, 'Developer'),
// (19,'Laptop Dell Inspiron 15 với chip Intel i5 thế hệ 12, RAM 8GB, SSD
// 512GB.',
// 'Dell', 'dell-inspiron.jpg', 'Laptop Dell Inspiron 15', 15000000, 50, 'Laptop
// văn phòng giá rẻ', 120, 'Sinh viên');
