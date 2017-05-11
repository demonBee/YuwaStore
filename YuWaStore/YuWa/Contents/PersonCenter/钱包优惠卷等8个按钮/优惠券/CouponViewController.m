//
//  CouponViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/12.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "CouponViewController.h"

#import "YJSegmentedControl.h"
#import "PCCouponTableViewCell.h"    //cell

#import "JWTools.h"



#define CELL0    @"PCCouponTableViewCell"

@interface CouponViewController ()<UITableViewDelegate,UITableViewDataSource,YJSegmentedControlDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,assign)NSUInteger whichCategory; //0 1 2  可用 已使用 已过期


@property(nonatomic,strong)NSMutableArray*modelUsed;
@property(nonatomic,strong)NSMutableArray*modelUnused;
@property(nonatomic,strong)NSMutableArray*modelOvertime;



@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title=@"优惠券";
    [self getDatas];
    
    [self makeTopView];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
}

-(void)makeTopView{
    NSArray*array=@[@"可用",@"已使用",@"已过期"];
   UIView*view= [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 64, kScreen_Width, 44) titleDataSource:array backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:14] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
    [self.view addSubview:view];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    switch (self.whichCategory) {
        case 0:
            return self.modelUnused.count;
            break;
        case 1:
            return self.modelUsed.count;
            break;
        case 2:
            return self.modelOvertime.count;
            break;
   
        default:
            break;
    }
    return self.modelUsed.count;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PCCouponTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    cell.selectionStyle=NO;
    NSMutableArray*mtArray=[NSMutableArray array];
    switch (self.whichCategory) {
        case 0:
            mtArray=self.modelUnused;
            break;
        case 1:
            mtArray=self.modelUsed;

            break;
        case 2:
            mtArray=self.modelOvertime;

            break;
            
        default:
            break;
    }
//    UIView*leftView=[cell viewWithTag:1];
//    leftView.backgroundColor=[UIColor greenColor];
//    
//    UIView*rightView=[cell viewWithTag:2];
//    rightView.backgroundColor=[UIColor blueColor];
    
    
    //3 4 5 6
    CouponModel*model=mtArray[indexPath.section];
    
    UILabel*dis_freeLabel=[cell viewWithTag:3];
    dis_freeLabel.text=[NSString stringWithFormat:@"%@元",model.discount_fee];
    
    UILabel*min_freeLabel=[cell viewWithTag:4];
    min_freeLabel.text=[NSString stringWithFormat:@"满%@减",model.min_fee];
    
    UILabel*title=[cell viewWithTag:5];
    title.text=model.name;
    
    NSString*startTime=[JWTools getTime:model.begin_time];
    NSString*endTime=[JWTools getTime:model.end_time];
    UILabel*timeLabel=[cell viewWithTag:6];
    timeLabel.text=[NSString stringWithFormat:@"抵用券%@至%@",startTime,endTime];
    

      return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.whichCategory==0) {
        
        if (!self.shopID||!self.totailPayMoney) {
            return;
        }
        
        
        
        
        NSInteger number=indexPath.section;
        CouponModel*model=self.modelUsed[number];
        
        CGFloat min_free=[model.min_fee floatValue];
        if (min_free>self.totailPayMoney) {
            [JRToast showWithText:@"不满足最低消费金额，不能使用该优惠券"];
            return;
        }
        
        if (![model.shop_id isEqualToString:@"0"]||![model.shop_id isEqualToString:self.shopID]) {
            [JRToast showWithText:@"该店铺不能使用这张优惠券"];
            return;
            
        }
        
        
        
            
            if ([self.delegate respondsToSelector:@selector(DelegateGetCouponInfo:)]) {
                [self.delegate DelegateGetCouponInfo:self.modelUsed[number]];
            }
            
            [self.navigationController popViewControllerAnimated:YES];

        
        
        
    }
    return;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark  --Datas
-(void)getDatas{
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_PERSON_COUPON];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid)};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSNumber*number=data[@"errorCode"];
        NSString*errorCode=[NSString stringWithFormat:@"%@",number];
        if ([errorCode isEqualToString:@"0"]) {
            //成功  给三个model 数组赋值
            NSArray*unused=data[@"data"][@"unused"];
            for (NSDictionary*dict in unused) {
                CouponModel*model=[CouponModel yy_modelWithDictionary:dict];
                [self.modelUnused addObject:model];
            }
            
            
            NSArray*used=data[@"data"][@"used"];
            for (NSDictionary*dict in used) {
              CouponModel*model=[CouponModel yy_modelWithDictionary:dict];
                [self.modelUsed addObject:model];
            }
            
         
            
            NSArray*overtime=data[@"data"][@"overtime"];
            for (NSDictionary*dict in overtime) {
                CouponModel*model=[CouponModel yy_modelWithDictionary:dict];
                [self.modelOvertime addObject:model];
            }
            
            [self.tableView reloadData];
            
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
        
    }];
    
    
}

#pragma mark  --delegate
-(void)segumentSelectionChange:(NSInteger)selection{
    self.whichCategory=selection;
    [self.tableView reloadData];
    MyLog(@"%lu",selection);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark  -- set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, kScreen_Width, kScreen_Height-64-44) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray *)modelUsed{
    if (!_modelUsed) {
        _modelUsed=[NSMutableArray array];
    }
    return _modelUsed;
}

-(NSMutableArray *)modelUnused{
    if (!_modelUnused) {
        _modelUnused=[NSMutableArray array];
    }
    return _modelUnused;
}

-(NSMutableArray *)modelOvertime{
    if (!_modelOvertime) {
        _modelOvertime=[NSMutableArray array];
    }
    return _modelOvertime;
}

@end
