package com.dy.utils;


import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 常量类，读取配置文件application.yml中的配置
 * @author dy
 */
@Component
public class FileUtils implements InitializingBean {

    public static String END_POINT;
    public static String KEY_ID;
    public static String KEY_SECRET;
    public static String BUCKET_NAME;
    @Value("${aliyun.oss.file.endpoint}")
    private String endpoint;
    @Value("${aliyun.oss.file.accessKeyId}")
    private String accessKeyId;
    @Value("${aliyun.oss.file.accessKeySecret}")
    private String accessKeySecret;
    @Value("${aliyun.oss.file.bucketName}")
    private String bucketName;

    @Override
    public void afterPropertiesSet() throws Exception {
        KEY_ID = this.accessKeyId;
        KEY_SECRET = this.accessKeySecret;
        END_POINT = this.endpoint;
        BUCKET_NAME = this.bucketName;
    }
}