//
//  StoreDescriptionTableViewCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/26.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "StoreDescriptionTableViewCell.h"

@interface StoreDescriptionTableViewCell()
@property(nonatomic,strong)NSMutableArray*saveAllLabel;

@end

@implementation StoreDescriptionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _saveAllLabel=[NSMutableArray array];
        
        UILabel*shopLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreen_Width-15, 30)];
        shopLabel.text=@"商家详情";
        shopLabel.font=FONT_CN_30;
        [self.contentView addSubview:shopLabel];
        
        
        
        
        
    }
    
    return self;
}



-(void)setAllDatas:(NSArray *)allDatas{
    _allDatas=allDatas;
    
    for (UIView*view in self.saveAllLabel) {
        [view removeFromSuperview];
    }
    self.saveAllLabel=[NSMutableArray array];
    
    
    
    CGFloat topPoint =30;
    for (int i=0; i<allDatas.count; i++) {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(15, topPoint, kScreen_Width-15, 30)];
        label.text=allDatas[i];
        label.font=FONT_CN_24;
        [self.contentView addSubview:label];
        [self.saveAllLabel addObject:label];
        
        topPoint=topPoint+30;
        
    }

    
}


+(CGFloat)getHeight:(NSArray*)array{
    
    NSInteger aa=array.count;
    return 30+30*aa;
  
}

@end
