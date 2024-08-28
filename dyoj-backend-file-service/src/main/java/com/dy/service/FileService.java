package com.dy.service;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author dy
 */
public interface FileService {
    /**
     * 上传头像到OSS
     *
     * @param file
     * @return
     */
    String uploadFileAvatar(MultipartFile file);
}
