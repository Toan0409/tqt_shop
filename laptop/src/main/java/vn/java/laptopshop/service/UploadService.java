package vn.java.laptopshop.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {
    private final ServletContext servletContext;

    public UploadService(ServletContext sevletContext) {
        this.servletContext = sevletContext;
    }

    public String handleSaveUploadFile(MultipartFile file, String targetFolder) {
        try {
            String realPath = servletContext.getRealPath("/images/");
            File dir = new File(realPath + File.separator + targetFolder);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            String originalFilename = System.currentTimeMillis() + "-" + file.getOriginalFilename();
            File serverFile = new File(dir.getAbsolutePath() + File.separator + originalFilename);

            try (BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile))) {
                stream.write(file.getBytes());
            }
            return originalFilename;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
