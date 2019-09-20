package com.heroxu.cicd.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @Value("${test-config}")
    private String testConfig;

    @GetMapping("/test")
    public String test() {
        return testConfig;
    }
}
