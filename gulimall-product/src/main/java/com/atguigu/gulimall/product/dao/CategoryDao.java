package com.atguigu.gulimall.product.dao;

import com.atguigu.gulimall.product.entity.CategoryEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 商品三级分类
 * 
 * @author au_miner
 * @email 358671982@qq.com
 * @date 2023-10-31 19:34:33
 */
@Mapper
public interface CategoryDao extends BaseMapper<CategoryEntity> {
	
}
