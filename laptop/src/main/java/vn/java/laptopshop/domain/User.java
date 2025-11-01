package vn.java.laptopshop.domain;

import java.util.List;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Entity
@Table(name = "users")
@Data
public class User {
    @Id
    @GeneratedValue(strategy = jakarta.persistence.GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Email(message = "Email không hợp lệ", regexp = "^[A-Za-z0-9+_.-]+@(.+)$")
    private String email;

    @NotBlank(message = "Mật khẩu không được để trống")
    @Size(min = 6, max = 100, message = "Mật khẩu phải có độ dài từ 6 đến 20 ký tự")
    private String password;

    @NotNull(message = "Họ và tên không được để trống")
    @Size(min = 1, max = 50, message = "Họ và tên phải có độ dài từ 1 đến 50 ký tự")
    private String fullName;

    private Long phoneNumber;
    private String address;
    private String avatar;

    // User - many => one - role
    @ManyToOne
    @JoinColumn(name = "role_id", nullable = false)
    private Role role;

    // user- one -> many order
    @OneToMany(mappedBy = "user")
    private List<Order> orders;

}
