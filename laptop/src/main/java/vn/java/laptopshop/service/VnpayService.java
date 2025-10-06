package vn.java.laptopshop.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;
import vn.java.laptopshop.config.ConfigVNPay;

@Service
public class VnpayService {
    public String createURLPayment(double totalPrice, HttpServletRequest request)
            throws UnsupportedEncodingException {

        // String orderType = "other";
        // long amount = Integer.parseInt(req.getParameter("amount"))*100;
        // String bankCode = req.getParameter("bankCode");
        long amount = (long) (totalPrice * 100);
        ; // Example amount in VND
        String vnp_TxnRef = ConfigVNPay.getRandomNumber(8);
        // String vnp_IpAddr = ConfigVNPay.getIpAddress(req);

        String vnp_TmnCode = ConfigVNPay.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", ConfigVNPay.vnp_Version);
        vnp_Params.put("vnp_Command", ConfigVNPay.vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_BankCode", "NCB");
        vnp_Params.put("vnp_CreateDate", "20220101103111");
        vnp_Params.put("vnp_CurrCode", "VND");

        vnp_Params.put("vnp_IpAddr", "13.160.92.202");
        vnp_Params.put("vnp_Locale", "vn");
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", "other");

        vnp_Params.put("vnp_ReturnUrl", ConfigVNPay.vnp_ReturnUrl);
        vnp_Params.put("vnp_ExpireDate", "20220101103111");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                // Build hash data
                hashData.append(fieldName);
                hashData.append('=');
                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                try {

                    // Build query
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                } catch (UnsupportedEncodingException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = ConfigVNPay.hmacSHA512(ConfigVNPay.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = ConfigVNPay.vnp_PayUrl + "?" + queryUrl;

        return paymentUrl;
    }

    public Map<String, String> getVnpayResponseParams(HttpServletRequest request) {
        Map<String, String> fields = new HashMap<>();
        Map<String, String[]> parameterMap = request.getParameterMap();

        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            String key = entry.getKey();
            String[] values = entry.getValue();
            if (values.length > 0) {
                fields.put(key, values[0]);
            }
        }

        return fields;
    }

    public boolean validateSignature(Map<String, String> vnpParams) {
        String vnpSecureHash = vnpParams.remove("vnp_SecureHash"); // lấy hash để so sánh
        vnpParams.remove("vnp_SecureHashType"); // không dùng khi tính hash

        // B1: Sắp xếp tham số theo thứ tự alphabet
        Map<String, String> sortedParams = new TreeMap<>(vnpParams);

        // B2: Tạo chuỗi dữ liệu để hash
        StringBuilder hashData = new StringBuilder();
        for (Map.Entry<String, String> entry : sortedParams.entrySet()) {
            if (hashData.length() > 0) {
                hashData.append('&');
            }
            hashData.append(entry.getKey()).append('=').append(entry.getValue());
        }

        // B3: Tính HMAC SHA512
        String secretKey = "GJ879X5OI58CN6QFX78XVBQSXHZJLBMI"; // thay bằng key thật từ VNPAY portal
        String calculatedHash = hmacSHA512(secretKey, hashData.toString());

        // So sánh chữ ký
        return calculatedHash.equalsIgnoreCase(vnpSecureHash);
    }

    public static String hmacSHA512(String key, String data) {
        try {
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "HmacSHA512");
            Mac mac = Mac.getInstance("HmacSHA512");
            mac.init(secretKeySpec);
            byte[] bytes = mac.doFinal(data.getBytes("UTF-8"));

            StringBuilder hash = new StringBuilder();
            for (byte b : bytes) {
                hash.append(String.format("%02x", b & 0xff));
            }
            return hash.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error while calculating HMAC SHA512", e);
        }
    }

}