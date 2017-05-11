//
//  PCCouponTableViewCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/12.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "PCCouponTableViewCell.h"

@implementation PCCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

//    UIView*viewleft=[self viewWithTag:1];
//  UIBezierPath*bezierPath=  [UIBezierPath bezierPathWithRoundedRect:viewleft.frame byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(6, 6)];
//    CAShapeLayer*shapeLayer=[[CAShapeLayer alloc]init];
//    shapeLayer.frame=viewleft.frame;
//    shapeLayer.path=bezierPath.CGPath;
//    viewleft.layer.mask=shapeLayer;
//    
//    
//    UIView*rightView=[self viewWithTag:2];
//    UIBezierPath*BPath=[UIBezierPath bezierPathWithRoundedRect:rightView.frame byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(6, 6)];
//    CAShapeLayer*sLayer=[[CAShapeLayer alloc]init];
//    sLayer.frame=rightView.frame;
//    sLayer.path=BPath.CGPath;
//    rightView.layer.mask=sLayer;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
