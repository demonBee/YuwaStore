//
//  DetailStoreFirstTableViewCell.h
//  YuWa
//
//  Created by 黄佳峰 on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailStoreFirstTableViewCell : UITableViewCell

@property(nonatomic,strong)void(^touchPayBlock)();

@property(nonatomic,strong)void(^touchLocateBlock)();

@property(nonnull,strong)void(^touchAddCollection)();
@property(nonatomic,copy)void(^touchPhoneBlock)();

@property(nonatomic,copy)void(^touchQiangBlock)();
@end
