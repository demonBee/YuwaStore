//
//  HomeMenuCell.h
//  meituan
//
//  Created by jinzelu on 15/6/30.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZMTBtnView.h"


@protocol HomeMenuCellDelegate <NSObject>

-(void)DelegateToChooseCategory:(NSInteger)number andCategoryID:(NSString*)idd;

@end

@interface HomeMenuCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSMutableArray *)menuArray;

@property(nonatomic,assign)id<HomeMenuCellDelegate>delegate;
@end
