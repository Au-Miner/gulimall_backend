package com.atguigu.gulimall.member.feign;

import com.atguigu.common.utils.R;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestMapping;


@FeignClient(value = "gulimall-coupon", path = "/coupon/coupon")
public interface CouponFeignService {

    @RequestMapping("/member/list")
    public R membercoupons();
}
