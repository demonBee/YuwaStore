//
//  OrderModel.h
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/15.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    "status" = 待付款,
//    "order_id" = 209,
//    "total_money" = 539.00,
//    "shop_img" = http://114.215.252.104/Public/Upload/20161107/14784877879161.jpg,
//    "non_discount_money" = 0.00,
//    "discount" = 0.00,
//    "shop_address" = 虹桥火车站二层麦当劳,
//    "shop_name" = McDolonds,
//    "pay_money" = 0.00,
//    "create_time" = 1474851923,
//    "shop_id" = 11,
//    }, 



@interface OrderModel : NSObject

@property(nonatomic,strong)NSString*status;
@property(nonatomic,strong)NSString*order_id;
@property(nonatomic,strong)NSString*shop_img;
@property(nonatomic,strong)NSString*non_discount_money;
@property(nonatomic,strong)NSString*shop_address;
@property(nonatomic,strong)NSString*create_time;

@property(nonatomic,strong)NSString*shop_id;   //店铺的id
@property(nonatomic,strong)NSString*shop_name;     //店铺的名字
@property(nonatomic,strong)NSString*pay_money;     //需要支付多少钱
@property(nonatomic,strong)NSString*discount;      //折扣
@property(nonatomic,strong)NSString*total_money;   //总共需要支付的钱

@end
