DROP TABLE IF EXISTS `mall_user`;

CREATE TABLE `mall_user` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL COMMENT '昵称',
    `nick_name` varchar(32) charset utf8 null,
    `gender` tinyint(1) DEFAULT NULL COMMENT '性别: 0-女,1-男，2-其他',
    `is_deleted` tinyint(1) DEFAULT 0 COMMENT '是否删除标记:1-删除，0-表示未删除',
    `password` varchar(125) charset utf8 not null,
    `email` varchar(255) charset utf8 null comment 'email',
    `mobile` varchar(11) charset utf8 not null comment '手机号码',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '用户表';

DROP TABLE IF EXISTS `mall_goods`;

CREATE TABLE `mall_goods` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(50) DEFAULT NULL COMMENT '名称',
    `code` varchar(255) DEFAULT NULL COMMENT 'code',
    `desc` varchar(500) DEFAULT NULL COMMENT '描述',
    `sales_num` int(11) DEFAULT NULL COMMENT '销量',
    `show_sales_num` tinyint(4) DEFAULT '0' COMMENT '是否在商品列表页、详情页展示销量, 1是 0否',
    `sell_status` tinyint(4) NOT NULL DEFAULT '2' COMMENT '销售状态 1 上架 2 下架 3 定时上架',
    `sell_at` datetime DEFAULT NULL COMMENT '上架时间',
    `detail` text COMMENT '商品详情',
    `type` int(11) DEFAULT NULL COMMENT '类型',
    `goods_category_id` bigint(20) DEFAULT NULL COMMENT '商品分类 mall_goods_category.id',
    `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
    `updated_by` bigint(20) DEFAULT NULL COMMENT '修改人',
    `seckill_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '秒杀状态(0:关闭;1:开启)',
    `seckill_start_time` datetime DEFAULT NULL COMMENT '秒杀开始时间',
    `seckill_end_time` datetime DEFAULT NULL COMMENT '秒杀结束时间',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '商品表';

DROP TABLE IF EXISTS `mall_goods_category`;

CREATE TABLE `mall_goods_category` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL COMMENT '分类名称',
    `pid` bigint(20) DEFAULT NULL COMMENT '父类id',
    `desc` varchar(255) DEFAULT NULL COMMENT '分类描述',
    `img` varchar(255) DEFAULT NULL COMMENT '分类图片',
    `show_status` tinyint(4) DEFAULT '0' COMMENT '是否显示 0/1',
    `recommend_status` tinyint(4) DEFAULT '0' COMMENT '是否推荐 0/1',
    `numerous_sell_status` tinyint(4) DEFAULT '0' COMMENT '是否热卖 0/1',
    `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
    `updated_by` bigint(20) DEFAULT NULL COMMENT '修改人',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '商品分类表';

DROP TABLE IF EXISTS `mall_goods_and_category_relationship`;

CREATE TABLE `mall_goods_category_relationship` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `goods_id` bigint(20) NOT NULL COMMENT 'goods.id',
    `goods_category_id` bigint(20) NOT NULL COMMENT 'goods_category.id',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

DROP TABLE IF EXISTS `mall_goods_specification`;

CREATE TABLE `mall_goods_specification` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL COMMENT '规格属性名称',
    `show` tinyint(4) DEFAULT '1' COMMENT '是否显示',
    `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
    `updated_by` bigint(20) DEFAULT NULL COMMENT '修改人',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '商品规格属性';

DROP TABLE IF EXISTS `mall_goods_specification_items`;

CREATE TABLE `mall_goods_specification_items` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `spec_id` bigint(20) DEFAULT NULL COMMENT '规格属性id',
    `value` varchar(255) DEFAULT NULL COMMENT '属性值',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '商品-商品分类关系表';

DROP TABLE IF EXISTS `mall_goods_image`;

CREATE TABLE `mall_goods_image` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `img_url` varchar(255) DEFAULT NULL COMMENT '图片地址',
    `goods_id` bigint(20) DEFAULT NULL COMMENT '商品id',
    `img_type` tinyint(4) DEFAULT NULL COMMENT '图片类型，1主图，2详情页图，3缩略图',
    `created_by` bigint(20) DEFAULT NULL COMMENT '创建人',
    `updated_by` bigint(20) DEFAULT NULL COMMENT '修改人',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '产品图片';

DROP TABLE IF EXISTS `mall_goods_inventory`;

CREATE TABLE `mall_goods_inventory` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL COMMENT '名称',
    `image` varchar(255) DEFAULT NULL COMMENT '图片',
    `code` varchar(255) DEFAULT NULL COMMENT '库存编号',
    `goods_id` bigint(20) DEFAULT NULL COMMENT '产品id',
    `price` decimal(8, 2) DEFAULT NULL COMMENT '价格',
    `original_price` decimal(8, 2) DEFAULT NULL COMMENT '原价',
    `quantity` int(11) DEFAULT NULL COMMENT '库存数量',
    `properties` varchar(255) DEFAULT NULL COMMENT '规格id组合值，多个以逗号分隔',
    `created_by` int(11) DEFAULT NULL COMMENT '创建人',
    `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '商品库存表';

DROP TABLE IF EXISTS `mall_order`;

CREATE TABLE `mall_order` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) DEFAULT NULL COMMENT '订单名称',
    `order_no` varchar(255) DEFAULT NULL COMMENT '订单号唯一值，供客户查询',
    `status` tinyint(4) DEFAULT NULL COMMENT '订单状态：1 未付款, 2 已付款(待发货), 3 已发货, 4 已签收, 5 退款申请, 6 退款中(待退款), 7 已退款, 8 取消交易\n',
    `goods_count` int(11) NOT NULL DEFAULT '0' COMMENT '商品数量, 商品项目数量，不是商品',
    `goods_amount_total` decimal(8, 2) NOT NULL DEFAULT '0.00' COMMENT '商品总价',
    `order_amount_total` decimal(8, 2) NOT NULL DEFAULT '0.00' COMMENT '订单金额 实际付款金额',
    `logistics_fee` decimal(8, 2) NOT NULL DEFAULT '0.00' COMMENT '运费金额',
    `address_id` bigint(20) DEFAULT NULL COMMENT '地址 user_address.id',
    `order_logistics_id` int(11) DEFAULT NULL COMMENT '订单物流编号',
    `transaction_id` varchar(255) DEFAULT NULL COMMENT '第三方支付流水号',
    `user_id` bigint(20) NOT NULL COMMENT '用户 wechat_user.id',
    `paid_at` datetime DEFAULT NULL COMMENT '付款时间',
    `delivery_at` datetime DEFAULT NULL COMMENT '发货时间',
    `memo` varchar(255) DEFAULT NULL COMMENT '客户备注',
    `complete_at` datetime DEFAULT NULL COMMENT '完成时间',
    `comment_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '评论状态 0未评论 1已评论',
    `receiver_name` varchar(255) DEFAULT NULL COMMENT '收货人',
    `receiver_phone` varchar(255) DEFAULT NULL COMMENT '收货人手机号',
    `receiver_address` varchar(255) DEFAULT NULL COMMENT '收货人地址',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '订单表';

DROP TABLE IF EXISTS `mall_order_details`;

CREATE TABLE `mall_order_details` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `order_id` bigint(20) NOT NULL COMMENT 'mall_order.id',
    `goods_id` bigint(20) NOT NULL COMMENT 'mall_goods.id',
    `goods_name` varchar(255) NOT NULL COMMENT '商品名称',
    `goods_price` decimal(8, 2) NOT NULL COMMENT '商品价格',
    `goods_marque` varchar(255) NOT NULL COMMENT '商品型号',
    `goods_mode_desc` varchar(255) NOT NULL COMMENT '商品型号信息 记录详细商品型号，如颜色、规格、包装等',
    `goods_mode_params` varchar(255) NOT NULL COMMENT 'JSON格式，记录单位编号、颜色编号、规格编号等',
    `amount` int(11) NOT NULL COMMENT '购买数量',
    `subtotal` decimal(8, 2) NOT NULL COMMENT '小计金额',
    `available` tinyint(4) NOT NULL DEFAULT '1' COMMENT '商品是否有效',
    `memo` varchar(255) NOT NULL COMMENT '客户商品备注',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 49 DEFAULT CHARSET = utf8 COMMENT = '订单快照表';

DROP TABLE IF EXISTS `mall_comment`;

CREATE TABLE `mall_comment` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `user_id` bigint(20) NOT NULL COMMENT '创建人',
    `goods_id` bigint(20) NOT NULL COMMENT '商品',
    `goods_sku_id` bigint(20) DEFAULT NULL COMMENT '商品规格id',
    `order_id` bigint(20) DEFAULT NULL COMMENT '订单',
    `content` longtext COMMENT '评论内容',
    `audit_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '审核状态：1未审核 2审核通过 3审核不通过',
    `audit_by` int(11) NOT NULL DEFAULT '0' COMMENT '审核人',
    `audit_at` datetime DEFAULT NULL COMMENT '审核时间',
    `created_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '创建人',
    `updated_by` bigint(20) NOT NULL DEFAULT '0' COMMENT '修改人',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '商品评论';

DROP TABLE IF EXISTS `mall_shopping_cart`;

CREATE TABLE `mall_shopping_cart` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `user_id` bigint(20) NOT NULL,
    `product_id` bigint(20) DEFAULT NULL COMMENT '商品id',
    `quantity` int(11) DEFAULT NULL COMMENT '数量',
    `checked` int(11) DEFAULT NULL COMMENT '是否选择,1=已勾选,0=未勾选',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COMMENT = '购物车';

DROP TABLE IF EXISTS `mall_user_addresses`;

CREATE TABLE `mall_user_addresses` (
    `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
    `location` varchar(255) NOT NULL COMMENT '省市区code, 逗号分隔',
    `region_id` int(11) DEFAULT NULL COMMENT '省份id',
    `city_id` int(11) DEFAULT NULL COMMENT '城市id',
    `address` varchar(255) DEFAULT NULL COMMENT '详细地址',
    `user_id` bigint(20) DEFAULT NULL COMMENT '用户 mall_user.id',
    `name` varchar(50) NOT NULL COMMENT '名称',
    `tel` varchar(20) DEFAULT NULL COMMENT '手机号',
    `tag` varchar(255) DEFAULT NULL COMMENT '标签',
    `default` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否默认 1是 0不是',
    `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8 COMMENT = '用户收货地址';