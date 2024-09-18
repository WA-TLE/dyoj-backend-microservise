package com.dy.judge.config;

import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @Author: dy
 * @Date: 2024/4/26 16:15
 * @Description:
 */
@Configuration
@Slf4j
public class ThreadPollExecutorConfig {

    @Bean
    public ThreadPoolExecutor threadPoolExecutor() {

        ThreadFactory threadFactory = new ThreadFactory() {
            private int cnt = 1;

            @Override
            public Thread newThread(@NotNull Runnable r) {
                Thread thread = new Thread(r);
                thread.setName("线程" + cnt);
                cnt ++;
                return thread;
            }
        };

        return new ThreadPoolExecutor(
                8,  // 核心线程数
                16, // 最大线程数
                300, // 线程存活时间
                TimeUnit.SECONDS,
                new ArrayBlockingQueue<>(10), // 队列大小
                threadFactory,
                new ThreadPoolExecutor.CallerRunsPolicy() // 拒绝策略
        );
    }
}
