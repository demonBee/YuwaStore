//
//  VIPTabBarController.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/9/1.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "VIPTabBarController.h"
#import "VIPTabBar.h"
#import "JWTabBar.h"
#import "VIPNavigationController.h"

#import "VIPHomePageViewController.h"
#import "RBHomeViewController.h"
#import "YWStormViewController.h"
#import "YWMessageViewController.h"
#import "VIPPersonCenterViewController.h"


#import "YWLoginViewController.h"

@implementation VIPTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    // tabBar 必定是灰色的  下面方法 可以改变选中时候的颜色
    [UITabBar appearance].tintColor=CNaviColor;
    [self addChildViewControllers];
    [self delTopLine];
    
    self.delegate=self;
}

- (void)delTopLine{
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
}

-(void)addChildViewControllers{
   
    VIPHomePageViewController*vc=[[VIPHomePageViewController alloc]init];
    [self addChildVC:vc withTitle:@"首页" withImage:@"home_0_nomal" withSelectedImage:@"home_0_selected"];
    
    RBHomeViewController*vcDiscover=[[RBHomeViewController alloc]init];
    [self addChildVC:vcDiscover withTitle:@"发现" withImage:@"home_1_nomal" withSelectedImage:@"home_1_selected"];
    
    YWStormViewController*vcStorm=[[YWStormViewController alloc]init];
    [self addChildVC:vcStorm withTitle:@"旋风" withImage:@"tabBar_publis_Search" withSelectedImage:@"tabBar_publis_Search"];
    
    YWMessageViewController*vcMessage=[[YWMessageViewController alloc]init];
    [self addChildVC:vcMessage withTitle:@"消息" withImage:@"home_3_nomal" withSelectedImage:@"home_3_selected"];
    
    VIPPersonCenterViewController*vcPerson=[[VIPPersonCenterViewController alloc]init];
    [self addChildVC:vcPerson withTitle:@"个人中心" withImage:@"home_4_nomal" withSelectedImage:@"home_4_selected"];
}


-(void)addChildVC:(UIViewController*)vc withTitle:(NSString*)title withImage:(NSString*)imageName withSelectedImage:(NSString*)selectedImageName{
    vc.tabBarItem.title=title;
    vc.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImageName];
    if ([vc isKindOfClass:[YWStormViewController class]]) {
        vc.tabBarItem.image = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(-8, 0, 8, 0)];//top = - bottom
    }
    
    VIPNavigationController*navi=[[VIPNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:navi];
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController.tabBarItem.title isEqualToString:@"个人中心"]) {
        if (![UserSession instance].isLogin) {
            YWLoginViewController * vc = [[YWLoginViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            UINavigationController*navi=[[UINavigationController alloc]initWithRootViewController:vc];
//            LoginController *vc = [LoginController new];
            [self presentViewController:navi animated:YES completion:nil];
            
            return NO;
        }else{
            return YES;
        }
        
    }
    
    return YES;
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    if ([viewController isKindOfClass:[VIPPersonCenterViewController class]]) {
//        MyLog(@"11");
//    }
//    
//}


@end
