-- 前端：客户端、总部端、门店端
-- 后端：应用层
-- 中台：效能中心、门店中心、商品中心

-- mobyprd_shop
ALTER TABLE sc_shop modify COLUMN latitude decimal(10,7)DEFAULT NULL COMMENT '纬度';
ALTER TABLE sc_shop modify COLUMN longitude decimal(10,7)DEFAULT NULL COMMENT '经度';
ALTER TABLE sc_shop ADD COLUMN location point DEFAULT NULL COMMENT '经纬度计算函数';
ALTER TABLE sc_shop ADD COLUMN location_type int(1) DEFAULT '0' COMMENT '是否启用地理位置,0未启用,1启用';
ALTER TABLE sc_shop ADD COLUMN shopping_type int(1) DEFAULT '0' COMMENT '是否开启模板商城,0关闭,1已开启';

-- mobyuat_efficiency
ALTER TABLE efficiency_appointment_record ADD `adviser_id`  varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预约顾问id';
ALTER TABLE efficiency_appointment_record ADD `adviser_name`  varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预约顾问名称';
ALTER TABLE efficiency_appointment_record ADD `car_model`  varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预约车型';
ALTER TABLE efficiency_appointment_record ADD `car_series`  varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预约车系';
ALTER TABLE efficiency_appointment_record ADD `appointment_code`  varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预约单号';
ALTER TABLE efficiency_appointment_record ADD `car_brand`  varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆品牌';
ALTER TABLE efficiency_appointment_record ADD `pic_url`  varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片url';
ALTER TABLE efficiency_appointment_record ADD `product_id`  varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品Id';
ALTER TABLE efficiency_appointment_record ADD `sell_price`  varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品优惠价';
ALTER TABLE efficiency_appointment_record ADD `car_name`  varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '车辆名称';