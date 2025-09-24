package vn.java.laptopshop.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.genai.Client;
import com.google.genai.types.GenerateContentResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import vn.java.laptopshop.domain.dto.RegisterDTO;

@Service
public class AiCustomerService {

    private final Client client;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public AiCustomerService(@Value("${gemini.api.key}") String apiKey) {
        // Khởi tạo client Gemini
        this.client = Client.builder()
                .apiKey(apiKey)
                .build();
    }

    public RegisterDTO generateRandomCustomer() {
        String modelName = "gemini-2.0-flash"; // có thể dùng gemini-1.5-flash nếu muốn
        String prompt = """
                Bạn là một AI chuyên tạo dữ liệu khách hàng Việt Nam giả lập.
                Hãy trả về một JSON với các trường sau:
                {
                  "fullName": "Họ và tên",
                  "email": "Email hợp lệ",
                  "phoneNumber": "Số điện thoại Việt Nam",
                  "address": "Địa chỉ ở Việt Nam",
                  "avatar": "Link ảnh avatar giả"
                }
                Chỉ trả JSON, không thêm chữ khác.
                """;

        try {
            // gọi model trực tiếp
            GenerateContentResponse response = client.models.generateContent(
                    modelName,
                    prompt,
                    null);

            String rawText = response.text();

            // Làm sạch JSON (trường hợp có markdown ```json ... ```)
            String cleaned = rawText
                    .replaceAll("```json", "")
                    .replaceAll("```", "")
                    .trim();

            int start = cleaned.indexOf("{");
            int end = cleaned.lastIndexOf("}");
            if (start != -1 && end != -1) {
                cleaned = cleaned.substring(start, end + 1);
            }

            return objectMapper.readValue(cleaned, RegisterDTO.class);

        } catch (Exception e) {
            throw new RuntimeException("Lỗi khi tạo khách hàng giả từ Gemini", e);
        }
    }
}
