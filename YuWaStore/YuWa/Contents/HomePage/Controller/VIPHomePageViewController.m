//
//  HomePageViewController.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/9/1.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "VIPHomePageViewController.h"
#import "SDCycleScrollView.h"
#import "HomeMenuCell.h"
#import "ShoppingTableViewCell.h"
#import "YWMainShoppingTableViewCell.h"

#import "HPBannerModel.h"
#import "HPCategoryModel.h"
#import "HPTopShopModel.h"
#import "HPRecommendShopModel.h"


#import "NewMainCategoryViewController.h"   //18个分类
#import "YWShoppingDetailViewController.h"    //店铺详情
#import "NewSearchViewController.h"        //搜索界面
#import "WLBarcodeViewController.h"     //新的扫2维码
#import "YWPayViewController.h"      //优惠买单界面
#import "H5LinkViewController.h"    //webView
#import "YWMessageNotificationViewController.h"  //通知




//
#define CELL0   @"HomeMenuCell"
#define CELL1   @"ShoppingTableViewCell"
#define CELL2   @"YWMainShoppingTableViewCell"

@interface VIPHomePageViewController()<UITableViewDelegate,UITableViewDataSource,HomeMenuCellDelegate,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UIView*centerView;   //导航栏上的view
@property(nonatomic,strong)UIBarButtonItem*leftItem;
@property(nonatomic,strong)UIBarButtonItem*rightItem;
@property(nonatomic,strong)UIBarButtonItem*rightItem2;
@property(nonatomic,strong)NSString *saveQRCode;   //保存二维码



@property(nonatomic,strong)NSMutableArray*meunArrays;   //20个类
@property (nonatomic,strong)CLGeocoder * geocoder;
@property(nonatomic,strong)NSString*coordinatex;   //经度
@property(nonatomic,strong)NSString*coordinatey;   //维度
@property(nonatomic,assign)int pages;
@property(nonatomic,assign)int pagen;

//都是model
@property(nonatomic,strong)NSMutableArray*mtModelArrBanner;
@property(nonatomic,strong)NSMutableArray*mtModelArrCategory;
@property(nonatomic,strong)NSMutableArray*mtModelArrTopShop;
@property(nonatomic,strong)NSMutableArray*mtModelArrRecommend;

@end

@implementation VIPHomePageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //得到坐标
    [self getLocalSubName];

    
    [self makeNaviBar];
    
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[ShoppingTableViewCell class] forCellReuseIdentifier:CELL1];
    [self.tableView registerNib:[UINib nibWithNibName:CELL2 bundle:nil] forCellReuseIdentifier:CELL2];
    [self setUpMJRefresh];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0 ]setAlpha:1];
    
//    [self makeNoticeWithTime:0 withAlertBody:@"您已购买了xxxx"];
    
}

#pragma mark  -- 得到地理位置
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)getLocalSubName{
    CLLocation * location = [[CLLocation alloc]initWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull placemark, NSUInteger idx, BOOL * _Nonnull stop) {//地址反编译
           
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways ||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
                MyLog(@"current location is %@",placemark.subLocality);//红灯区
                //已经定位了
                self.coordinatex=[NSString stringWithFormat:@"%f",self.location.coordinate.longitude];  //维度
                
                self.coordinatey=[NSString stringWithFormat:@"%f",self.location.coordinate.latitude];   //经度
                //把取得的经纬度给后台
                [self updateCoordinate];
                
            }else{
                //泉州市    就是没有定位
                MyLog(@"11");
                
                
            }
        }];
    }];
    
//     self.location.lat,self.location.lon
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.y>0) {
       
        if (self.centerView.width !=kScreen_Width- 40.f) {
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationItem.rightBarButtonItems=nil;
            [UIView animateWithDuration:0.25 animations:^{
                self.centerView.width=kScreen_Width- 40.f;
                
            }];
        }
        
    }else if (scrollView.contentOffset.y<0){
        if (self.centerView.width!=kScreen_Width/2) {
            self.navigationItem.leftBarButtonItem = self.leftItem;
            self.navigationItem.rightBarButtonItems=@[self.rightItem2,self.rightItem];
            
            [UIView animateWithDuration:0.25 animations:^{
            self.centerView.width=kScreen_Width/2;
                
            }];

        }
        
    }
}

-(void)makeNaviBar{
    UIButton*buttonTitle=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 25)];
    buttonTitle.titleLabel.font=[UIFont systemFontOfSize:14];
    [buttonTitle setTitle:@"泉州市" forState:UIControlStateNormal];
//    [buttonTitle setImage:[UIImage imageNamed:@"page_downArr"] forState:UIControlStateNormal];
    [buttonTitle addTarget:self action:@selector(touchNaviCity) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:buttonTitle];
//    //变换两者的位置
//    [buttonTitle setTitleEdgeInsets:UIEdgeInsetsMake(0, -buttonTitle.imageView.bounds.size.width, 0, buttonTitle.imageView.bounds.size.width)];
//    [buttonTitle setImageEdgeInsets:UIEdgeInsetsMake(0, buttonTitle.titleLabel.bounds.size.width, 0, -buttonTitle.titleLabel.bounds.size.width)];
    
    
    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button setBackgroundImage:[UIImage imageNamed:@"page_saomiao"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchSaomiao) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIButton*button2=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"page_lingdang"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(touchLingdang) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem2=[[UIBarButtonItem alloc]initWithCustomView:button2];
    
    self.navigationItem.leftBarButtonItem=leftItem;
    self.navigationItem.rightBarButtonItems=@[rightItem2,rightItem];
    
    UIView*centerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width/2, 30)];
    centerView.backgroundColor=[UIColor whiteColor];
    centerView.layer.cornerRadius=6;
    self.centerView=centerView;
    //centview 上的元素
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    imageView.image=[UIImage imageNamed:@"page_navi_sousuo"];
    [self.centerView addSubview:imageView];
    
    UILabel*showLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 5, self.centerView.width-60, 20)];
    showLabel.font=[UIFont systemFontOfSize:14];
    showLabel.textColor=CtitleColor;
    showLabel.text=@"美食";
    [self.centerView addSubview:showLabel];
    
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchinPut)];
    [self.centerView addGestureRecognizer:tap];
    
    
    
    self.navigationItem.titleView=centerView;
    self.leftItem=leftItem;
    self.rightItem=rightItem;
    self.rightItem2=rightItem2;
    
    
    
    
}




-(void)setUpMJRefresh{
    self.pagen=10;
    self.pages=-1;

    self.tableView.mj_header=[UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        [self getDatas];
    }];
    
    //上拉刷新
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        [self loadingMoreShowInfo];
    }];
 
    
    //立即刷新
    [self.tableView.mj_header beginRefreshing];
    

    
    
 
    
}


#pragma mark -- Datas

-(void)getDatas{
    self.pagen=10;
    self.pages=-1;
    
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_HOME_PAGE];

    NSMutableDictionary*params=[NSMutableDictionary dictionary];
    [params setObject:[JWTools getUUID] forKey:@"device_id"];
    if (self.coordinatex) {
        [params setObject:self.coordinatex forKey:@"coordinatex"];
    }else if (self.coordinatey){
        [params setObject:self.coordinatey forKey:@"coordinatey"];
    }
    [self.mtModelArrRecommend removeAllObjects];
                self.mtModelArrRecommend=nil;
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSString*errorCode=[NSString stringWithFormat:@"%@",data[@"errorCode"]];
        if ([errorCode isEqualToString:@"0"]) {
            self.mtModelArrBanner=nil;
            self.mtModelArrCategory=nil;
            self.mtModelArrTopShop=nil;
            [self.mtModelArrRecommend removeAllObjects];
            self.mtModelArrRecommend=nil;
            
            
            NSArray*banner=data[@"data"][@"flash"];
            for (int i=0; i<banner.count; i++) {
             HPBannerModel*model= [HPBannerModel yy_modelWithDictionary:banner[i]];
                [self.mtModelArrBanner addObject:model];
                
            }
            
            NSArray*category=data[@"data"][@"category"];
            for (NSDictionary*dict in category) {
              HPCategoryModel*model=[HPCategoryModel yy_modelWithDictionary:dict];
                [self.mtModelArrCategory addObject:model];
                
            }
            
            NSArray*topShop=data[@"data"][@"top_shop"];
            for (NSDictionary*dict in topShop) {
                HPTopShopModel*model=[HPTopShopModel yy_modelWithDictionary:dict];
                [self.mtModelArrTopShop addObject:model];
            }
            
            NSArray*recommendShop=data[@"data"][@"recommend_shop"];
            for (NSDictionary*dict in recommendShop) {
                HPRecommendShopModel*model=[HPRecommendShopModel yy_modelWithDictionary:dict];
                [self.mtModelArrRecommend addObject:model];
            }
            
            
            
            [self.tableView reloadData];
            
        }else{
            [JRToast showWithText:@"errorMessage"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];

        });
        
        
        
    }];
    
}

-(void)loadingMoreShowInfo{
    self.pages++;
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_HOME_MORELOADING];
    NSString*pagen=[NSString stringWithFormat:@"%d",self.pagen];
    NSString*pages=[NSString stringWithFormat:@"%d",self.pages];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"pagen":pagen,@"pages":pages};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSNumber*number=data[@"errorCode"];
        NSString*errorCode=[NSString stringWithFormat:@"%@",number];
        if ([errorCode isEqualToString:@"0"]) {
            NSArray*array=data[@"data"];
            for (NSDictionary*dict in array) {
                HPRecommendShopModel*model=[HPRecommendShopModel yy_modelWithDictionary:dict];
                [self.mtModelArrRecommend addObject:model];
                
                
            }
            [self.tableView reloadData];
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
            
        }
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        });
    }];
    
    
}


//把取得的经纬度给后台
-(void)updateCoordinate{
    if (!self.coordinatex||!self.coordinatey) {
        return;
    }
    
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_HOME_UPDATECOORDINATE];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"coordinatex":self.coordinatex,@"coordinatey":self.coordinatey};
   HttpManager*manager= [[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        //更新成功
        MyLog(@"%@",data);
        
        
    }];
  
}


-(void)getDatasWithIDD:(NSString*)idd{
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_QRCODE_ID];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"code":idd};
    
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        
        NSString*company_name=data[@"data"][@"company_name"];   //这个 名字 需要改。
        NSString*shopID=data[@"data"][@"seller_uid"];
        CGFloat discount=[data[@"data"][@"discount"] floatValue];
        CGFloat total_money=[data[@"data"][@"total_money"] floatValue];
        CGFloat non_discount_money=[data[@"data"][@"non_discount_money"] floatValue];
        
        YWPayViewController*vc=[YWPayViewController payViewControllerCreatWithQRCodePayAndShopName:company_name andShopID:shopID andZhekou:discount andpayAllMoney:total_money andNOZheMoney:non_discount_money];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
}


#pragma mark -- UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return self.mtModelArrRecommend.count;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];

    
    if (indexPath.section==0) {
        HomeMenuCell*cell = [[HomeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL0 menuArray:self.mtModelArrCategory];
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        return cell;

        
    }else if (indexPath.section==1){
        
        ShoppingTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        cell.selectionStyle=NO;
        cell.allDatas=self.mtModelArrTopShop;
        WEAKSELF;
        cell.touchCollectionViewBlock=^(NSInteger number){
            HPTopShopModel*model=self.mtModelArrTopShop[number];
            MyLog(@"id=%@",model.id);

            YWShoppingDetailViewController*vc=[[YWShoppingDetailViewController alloc]init];
            vc.shop_id=model.id;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        };
            

        
        return cell;
        
    }else if (indexPath.section==2){
       YWMainShoppingTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:CELL2];
        cell.selectionStyle=NO;
 
        NSInteger number=indexPath.row;
        HPRecommendShopModel*model=self.mtModelArrRecommend[number];
        
        //图片
        UIImageView*photo=[cell viewWithTag:1];
        [photo sd_setImageWithURL:[NSURL URLWithString:model.company_img] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageAllowInvalidSSLCertificates completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        //标题
        UILabel*titleLabel=[cell viewWithTag:2];
        titleLabel.text=model.company_name;
        
//星星数量 -------------------------------------------------------
        CGFloat realZhengshu;
        CGFloat realXiaoshu;
        NSString*starNmuber=model.star;
        NSString*zhengshu=[starNmuber substringToIndex:1];
        realZhengshu=[zhengshu floatValue];
        NSString*xiaoshu=[starNmuber substringFromIndex:1];
        CGFloat CGxiaoshu=[xiaoshu floatValue];
        
        if (CGxiaoshu>0.5) {
            realXiaoshu=0;
           realZhengshu= realZhengshu+1;
        }else if (CGxiaoshu>0&&CGxiaoshu<=0.5){
             realXiaoshu=0.5;
        }else{
              realXiaoshu=0;

        }
        
        for (int i=30; i<35; i++) {
            UIImageView*imageView=[cell viewWithTag:i];
            if (imageView.tag-30<realZhengshu) {
                //亮
                imageView.image=[UIImage imageNamed:@"home_lightStar"];
            }else if (imageView.tag-30==realZhengshu&&realXiaoshu!=0){
                //半亮
                imageView.image=[UIImage imageNamed:@"home_halfStar"];
                
            }else{
                //不亮
                imageView.image=[UIImage imageNamed:@"home_grayStar"];
            }
            
            
        }
//---------------------------------------------------------------------------
        
        
        //人均
        UILabel*per_capitaLabel=[cell viewWithTag:3];
        per_capitaLabel.text=[NSString stringWithFormat:@"%@/人",model.per_capita];
        
        //分类
        UILabel*categoryLabel=[cell viewWithTag:4];
        NSArray*array=model.tag_name;
        NSString*arrayStr=[array componentsJoinedByString:@" "];
        categoryLabel.text=[NSString stringWithFormat:@"%@ %@",model.catname,arrayStr];   //model.catname
        
        //店铺所在的商圈
        UILabel*shopLocLabel=[cell viewWithTag:6];
        shopLocLabel.text=model.company_near;
        
        
        //距离自己的位置多远
//        UILabel*nearLabel=[cell viewWithTag:5];
//        nearLabel.text=[NSString stringWithFormat:@"%@km",model.company_near];
        
        
        //这下面的文字
        UILabel*zheLabel=[cell viewWithTag:7];
        NSString*zheNum=[model.discount substringFromIndex:2];
        zheLabel.text=[NSString stringWithFormat:@"%@折，闪付立享",zheNum];

        CGFloat num=[model.discount floatValue];
        if (num>=1) {
              zheLabel.text=@"不打折";
        }
        
        
        
        //特图片
        UIImageView*imageTe=[cell viewWithTag:8];
        imageTe.hidden=YES;
        //特旁边的文字
        UILabel*teLabel=[cell viewWithTag:9];
        teLabel.hidden=YES;
        
        //显示的特别活动   nsarray 里面string越多 显示越多的内容
        
        cell.holidayArray=model.holiday;

        
        return cell;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        NSInteger number=indexPath.row;
        HPRecommendShopModel*model=self.mtModelArrRecommend[number];

        
        YWShoppingDetailViewController*vc=[[YWShoppingDetailViewController alloc]init];
        vc.shop_id=model.id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 180;
    }else if (indexPath.section==1){
        return 200;
    }
    
    else{
        //最后一排 来判断得到的高度
//          return 145;
        HPRecommendShopModel*model=self.mtModelArrRecommend[indexPath.row];
        return [YWMainShoppingTableViewCell getCellHeight:model.holiday];
    
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return ACTUAL_HEIGHT(125);
        
    }else if (section==2){
        return 40;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        NSMutableArray*mtArray=[NSMutableArray array];
        for (HPBannerModel*model in self.mtModelArrBanner) {
            [mtArray addObject:model.img];
        }
        
        
        
        SDCycleScrollView*sdView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, ACTUAL_HEIGHT(125)) imagesGroup:mtArray andPlaceholder:@"placehoder_loading"];
        sdView.autoScrollTimeInterval=5.0;
        sdView.delegate=self;
        return sdView;
        
        
    }else if (section==2){
        UIView*view=[[UIView alloc]init];
        view.backgroundColor=[UIColor whiteColor];
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 15, 15)];
        //        imageView.backgroundColor=[UIColor greenColor];
        imageView.image=[UIImage imageNamed:@"home_heart"];
        [view addSubview:imageView];
        
        UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+15+10, 15, kScreen_Width/2, 15)];
        titleLabel.textColor=CNaviColor;
        titleLabel.text=@"为你推荐";
        titleLabel.font=FONT_CN_30;
        [view addSubview:titleLabel];
        
        
        return view;

        
    }
    
    return nil;
    
}

#pragma mark  -- touch
-(void)touchNaviCity{
    //城市
    
}

#pragma mark  --  二维码
-(void)touchSaomiao{
    WLBarcodeViewController *vc=[[WLBarcodeViewController alloc] initWithBlock:^(NSString *str, BOOL isScceed) {
        
        if (isScceed) {
          //扫描结果 成功
            self.saveQRCode=str;
            
            
            if (![str hasPrefix:@"yvwa.com/"]) {
                NSArray*array=[str componentsSeparatedByString:@"/"];
                NSString*idd=array.lastObject;
                
                //这里吊接口 通过这 idd
                [self getDatasWithIDD:idd];
                
                
                return ;
            }else{
            
            
            
            
            //不是我们的二维码
            NSString*strr=[NSString stringWithFormat:@"可能存在风险，是否打开此链接?\n %@",str];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:strr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开链接", nil];
            [alert show];

            
            //
            
            
            }
            
            
            
        }else{
           //扫描结果不成功
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫码结果" message:@"无法识别" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    
    
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //没有0 的 只有1
    if (buttonIndex==1) {
        H5LinkViewController *h5LinkVC = [[H5LinkViewController alloc]init];
        h5LinkVC.h5LinkString = self.saveQRCode;
        [self.navigationController pushViewController:h5LinkVC animated:YES];
        
    }
    
    
}


-(void)touchLingdang{
    YWMessageNotificationViewController*vc=[[YWMessageNotificationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

    
   
    
}
//点击输入框
-(void)touchinPut{
    NewSearchViewController*vc=[[NewSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark  --delegate
//轮播图
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
//    MyLog(@"%ld",(long)index);    //缺少id
    HPBannerModel*model=self.mtModelArrBanner[index];
    //这个就是id
    model.url;
    
    YWShoppingDetailViewController*vc=[[YWShoppingDetailViewController alloc]init];
    vc.shop_id=model.url;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


-(void)DelegateToChooseCategory:(NSInteger)number andCategoryID:(NSString *)idd{
    MyLog(@"aaa%lu,bbb%@",number,idd);
    if (number==1) {
        //电影
        
        
        
    }else if (number==2){
        //酒店
        
        
    }else if (number!=1&&number!=2){
//        YWMainCategoryViewController*vc=[[YWMainCategoryViewController alloc]initWithNibName:@"YWMainCategoryViewController" bundle:nil];
//        [self.navigationController pushViewController:vc animated:YES];

        NewMainCategoryViewController*vc=[[NewMainCategoryViewController alloc]init];
        vc.categoryTouch=number;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
}



#pragma mark  --set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}




-(NSMutableArray *)mtModelArrBanner{
    if (!_mtModelArrBanner) {
        _mtModelArrBanner=[NSMutableArray array];
    }
    return _mtModelArrBanner;
}

-(NSMutableArray *)mtModelArrCategory{
    if (!_mtModelArrCategory) {
        _mtModelArrCategory=[NSMutableArray array];
    }
    return _mtModelArrCategory;
}

-(NSMutableArray *)mtModelArrTopShop{
    if (!_mtModelArrTopShop) {
        _mtModelArrTopShop=[NSMutableArray array];
    }
    return _mtModelArrTopShop;
}

-(NSMutableArray *)mtModelArrRecommend{
    if (!_mtModelArrRecommend) {
        _mtModelArrRecommend=[NSMutableArray array];
    }
    return _mtModelArrRecommend;
}

@end
