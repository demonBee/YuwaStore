//
//  YWMainShoppingTableViewCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWMainShoppingTableViewCell.h"

@interface YWMainShoppingTableViewCell()
@property(nonatomic,strong)NSMutableArray*saveAllImage;
@property(nonatomic,strong)NSMutableArray*saveAllLabel;

@end
@implementation YWMainShoppingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    
    
    
}

-(void)setHolidayArray:(NSArray *)holidayArray{
    _holidayArray=holidayArray;
    
    //显示的特别活动
    NSArray*specail=holidayArray;
    CGFloat top=118.0;
    CGFloat left=82;
     //首先移除所有的东西
    for (UIView*view in self.saveAllImage) {
        [view removeFromSuperview];
    }
    
    for (UIView*view2 in self.saveAllLabel) {
        [view2 removeFromSuperview];
    }
    if (specail.count>0) {
       for (int i=0; i<specail.count; i++) {
            
            UIImageView*speImage=[self viewWithTag:200+i];
            if (!speImage) {
                speImage=[[UIImageView alloc]initWithFrame:CGRectMake(left, top, 15, 15)];
                speImage.tag=200+i;
            }
            [self.contentView addSubview:speImage];
            [self.saveAllImage addObject:speImage];
            speImage.image=[UIImage imageNamed:@"home_te.png"];
            
            
            
            
            UILabel*specailLabel=[self viewWithTag:300+i];
            if (!specailLabel) {
                specailLabel=[[UILabel alloc]initWithFrame:CGRectMake(102, top, kScreen_Width-110, 18)];
                specailLabel.centerY=speImage.centerY;
                specailLabel.font=[UIFont systemFontOfSize:15];
                specailLabel.tag=300+i;
                
            }
            [self.contentView addSubview:specailLabel];
            [self.saveAllLabel addObject:specailLabel];
            NSDictionary*dict=specail[i];
           NSString*zheNum=[dict[@"rebate"] substringFromIndex:2];
           specailLabel.text=[NSString stringWithFormat:@"%@折,闪付特享",zheNum];
           
           CGFloat numF=[dict[@"rebate"] floatValue];
           if (numF>=1) {
                specailLabel.text=@"无特惠";
           }
//            specailLabel.text=[NSString stringWithFormat:@"%@折，%@",dict[@"rebate"],dict[@"title"]];
           
            
            top=top+18+10;
        }
        
    }else{
        MyLog(@"11");
        
    }

    
}


+(CGFloat)getCellHeight:(NSArray*)array{
    CGFloat top=118.0;
    for (int i=0; i<array.count; i++) {
        top=top+18+10;
    }
    
    return top;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(NSMutableArray *)saveAllImage{
    if (!_saveAllImage) {
        _saveAllImage=[NSMutableArray array];
    }
    return _saveAllImage;
    
}

-(NSMutableArray *)saveAllLabel{
    if (!_saveAllLabel) {
        _saveAllLabel=[NSMutableArray array];
    }
    return _saveAllLabel;
}

@end
