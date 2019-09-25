//
//  ZY_TabBarController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_TabBarController.h"
#import "ZY_RootNavController.h"
@interface ZY_TabBarController ()

@end

@implementation ZY_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [UITabBar appearance].translucent = NO;//禁止移位的方法
    [self addChildViewControllers];
}
//添加子控制器
- (void)addChildViewControllers{
    //设置颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor chains_colorWithHexString:kDarkColor alpha:1],NSFontAttributeName : [UIFont systemFontOfSize:11.0f]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor chains_colorWithHexString:kThemeColor alpha:1],NSFontAttributeName : [UIFont systemFontOfSize:11.0f]} forState:UIControlStateSelected];
    //图片大小建议32*32
    [self addChildViewControllerClassName:@"ZY_HomeViewController" title:@"首页" imageName:@"home"];
    [self addChildViewControllerClassName:@"ZY_CheckedViewController" title:@"查件" imageName:@"checked"];
    [self addChildViewControllerClassName:@"ZY_MallViewController" title:@"商城" imageName:@"mall"];
    [self addChildViewControllerClassName:@"ZY_MineViewController" title:@"我的" imageName:@"mine"];
}
#pragma mark - 设置所有子控制器
- (void)addChildViewControllerClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName{
    
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    ZY_RootNavController *nav = [[ZY_RootNavController alloc] initWithRootViewController:viewController];
    viewController.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed: imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    
}

@end
