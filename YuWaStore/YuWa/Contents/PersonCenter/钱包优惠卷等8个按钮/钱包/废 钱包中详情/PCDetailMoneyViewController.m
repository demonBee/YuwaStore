//
//  PCDetailMoneyViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/11.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//



#import "PCDetailMoneyViewController.h"

#import "PCMoneyDetailTableViewCell.h"    //cell
#import "YJSegmentedControl.h"
#import "JWTools.h"
#import "MoneyPackModel.h"


#define CELL0  @"PCMoneyDetailTableViewCell"

@interface PCDetailMoneyViewController ()<UITableViewDelegate,UITableViewDataSource,YJSegmentedControlDelegate>

@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)NSMutableArray*maAllDatasModel;   //保存所有的model
@property(nonatomic,assign)int payType;         //类别1为收入，2为支出
@property(nonatomic,assign)int pagen;
@property(nonatomic,assign)int pages;
@end

@implementation PCDetailMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title=@"收支明细";
    [self makeTopView];
    [self.view addSubview: self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"PCMoneyDetailTableViewCell" bundle:nil] forCellReuseIdentifier:CELL0];
    
    [self setUpMJRefresh];

}

#pragma mark  -- UI

-(void)makeTopView{
    
    NSArray*titleArray=@[@"收入详情",@"支出详情"];
   UIView*topView= [YJSegmentedControl  segmentedControlFrame:CGRectMake(0, 64, kScreen_Width, 44) titleDataSource:titleArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:14] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
    [self.view addSubview:topView];
    
}

-(void)setUpMJRefresh{
    self.maAllDatasModel=[NSMutableArray array];
    self.payType=1;
    self.pagen=10;
    self.pages=0;
    
    self.tableView.mj_header=[UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.maAllDatasModel=[NSMutableArray array];
        self.pages=0;
        [self getDatas];
    }];
    
    //上拉刷新
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.pages++;
        [self getDatas];
    }];
    
    
    //立即刷新
    [self.tableView.mj_header beginRefreshing];
    
    
    
    
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.maAllDatasModel.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    cell.selectionStyle=NO;
    MoneyPackModel*model=self.maAllDatasModel[indexPath.row];
    
    UILabel*titleLabel=[cell viewWithTag:1];
    titleLabel.text=model.log_info;
    
    UILabel*timeLabel=[cell viewWithTag:2];
    timeLabel.text=[JWTools getTime:model.ctime];
    
    UILabel*moneyLabel=[cell viewWithTag:3];
    moneyLabel.text=[NSString stringWithFormat:@"+%@",model.money];
    
  
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}


#pragma mark  --Datas
-(void)getDatas{
    //,HTTP_GETPAYDETAIL
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS];
    NSString*pagen=[NSString stringWithFormat:@"%d",self.pagen];
    NSString*pages=[NSString stringWithFormat:@"%d",self.pages];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"type":@(self.payType),@"pagen":pagen,@"pages":pages};
    
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSNumber*number=data[@"errorCode"];
        NSString*errorCode=[NSString stringWithFormat:@"%@",number];
        if ([errorCode isEqualToString:@"0"]) {
            for (NSDictionary*dict in data[@"data"]) {
                MoneyPackModel*model=[MoneyPackModel yy_modelWithDictionary:dict];
                [self.maAllDatasModel addObject:model];
                
            }
            
            [self.tableView reloadData];
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
    }];
    
}


#pragma mark  --delegate
-(void)segumentSelectionChange:(NSInteger)selection{
    NSInteger aa=selection+1;
    self.payType=(short)aa;
    
    //立即刷新
    [self.tableView.mj_header beginRefreshing];

    
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, kScreen_Width, kScreen_Height-64-44) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
