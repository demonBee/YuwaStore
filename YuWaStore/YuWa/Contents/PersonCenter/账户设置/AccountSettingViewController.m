//
//  AccountSettingViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/8.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "VIPTabBarController.h"

#import "JWThirdTools.h"

@interface AccountSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"系统设置";
    [self.view addSubview:self.tableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0]setAlpha:1];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row==0) {
        cell.textLabel.text=@"清除缓存";
      NSArray*path=  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
      CGFloat aaa=  [JWThirdTools folderSizeAtPath:path[0]];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2fMB",aaa];
        
    }else if (indexPath.row==1){
        cell.textLabel.text=@"退出登录";
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        //清除缓存
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
        [JWThirdTools clearCache:paths[0]];
        [JRToast showWithText:@"缓存清除成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else if (indexPath.row==1){
        //
        [UserSession clearUser];
          VIPTabBarController *tabBar=[[VIPTabBarController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController=tabBar;
        
        
    }
    
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
