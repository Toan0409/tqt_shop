package vn.java.laptopshop.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import vn.java.laptopshop.service.validator.RegisterChecked;

@RegisterChecked
public class RegisterDTO {

    @NotBlank(message = "Mật khẩu không được để trống")
    @Size(min = 6, max = 20, message = "Mật khẩu phải có độ dài từ 6 đến 20 ký tự")
    private String password;

    @NotBlank(message = "Vui lòng nhập lại mật khẩu")
    private String confirmPassword;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ", regexp = "^[A-Za-z0-9+_.-]+@(.+)$")
    private String email;

    @NotBlank(message = "Họ và tên không được để trống")
    private String fullName;

    private long phoneNumber;

    private String address;
    private String avatar;
    private String roleName;

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public long getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(long phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

}
