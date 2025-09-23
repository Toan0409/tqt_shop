package vn.java.laptopshop.service.validator;

import org.springframework.stereotype.Service;
import vn.java.laptopshop.domain.dto.RegisterDTO;
import vn.java.laptopshop.service.UserService;

@Service
public class RegisterValidator implements jakarta.validation.ConstraintValidator<RegisterChecked, RegisterDTO> {

    private final UserService userService;

    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, jakarta.validation.ConstraintValidatorContext context) {
        boolean isValid = true;
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Mật khẩu và xác nhận mật khẩu không khớp")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation();
            isValid = false;

        }

        // check email
        if (this.userService.isEmailExists(user.getEmail())) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Email đã tồn tại")
                    .addPropertyNode("email")
                    .addConstraintViolation();
            isValid = false;
        }
        return isValid; // Placeholder for actual validation logic
    }

}
