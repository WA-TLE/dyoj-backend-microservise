package com.dy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @Author: dy
 * @Date: 2024/8/5 11:28
 * @Description:
 */
@RestController
@Service
public class TestController {


    @Autowired
    private DiscoveryClient discoveryClient;


    public static void main(String[] args) {
        TestController testController = new TestController();
        testController.test();
    }

    @GetMapping("/test")
    public String test() {
        List<ServiceInstance> instances = discoveryClient.getInstances("dyoj-backend-user-service");

        System.out.println(instances);

        if (instances != null && !instances.isEmpty()) {
            ServiceInstance serviceInstance = instances.get(0);
            return serviceInstance.getUri().toString();
        }
        return "Service instance not found";
    }
}
