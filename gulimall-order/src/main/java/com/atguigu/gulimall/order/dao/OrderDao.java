package com.atguigu.gulimall.order.dao;

import com.atguigu.gulimall.order.entity.OrderEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 订单
 * 
 * @author au_miner
 * @email 358671982@qq.com
 * @date 2023-11-01 09:26:40
 */
@Mapper
public interface OrderDao extends BaseMapper<OrderEntity> {
	
}
