package com.aeho.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class ProjectAehoApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectAehoApplication.class, args);
	}

}
