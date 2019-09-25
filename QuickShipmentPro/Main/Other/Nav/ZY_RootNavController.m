//
//  ZY_RootNavController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_RootNavController.h"

@interface ZY_RootNavController ()<UINavigationControllerDelegate>

@end

@implementation ZY_RootNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏背景色
    [self.navigationBar navBarBackGroundColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] image:nil isOpaque:YES];//颜色
    [self.navigationBar navBarBottomLineHidden:YES];//隐藏底线
    
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:ZYFontSize(17.0f),NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 导航栏左右按钮字体颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.delegate = self;

 
}
#pragma mark-----自定义返回按钮
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *root = navigationController.viewControllers[0];
    
    if (root != viewController) {
        UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backWhiteImg"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
        viewController.navigationItem.leftBarButtonItem = itemleft;
    }
}
#pragma mark-----返回按钮事件
- (void)popAction:(UIBarButtonItem *)barButtonItem{
    
    [self popViewControllerAnimated:YES];
}
//重写这个方法，在跳转后自动隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self.viewControllers count] > 0){
      
        viewController.hidesBottomBarWhenPushed = YES;
        //可以在这里定义返回按钮等
         UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backWhiteImg"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
        
         viewController.navigationItem.leftBarButtonItem = backItem;
         
    }
    //一定要写在最后，要不然无效
    [super pushViewController:viewController animated:animated];
    //处理了push后隐藏底部UITabBar的情况，并解决了iPhonX上push时UITabBar上移的问题。
    CGRect rect = self.tabBarController.tabBar.frame;
    rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
    self.tabBarController.tabBar.frame = rect;
}
/**
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
- (BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated{
    
    id vc = [self getCurrentViewControllerClass:ClassName];
    if(vc != nil && [vc isKindOfClass:[UIViewController class]])
    {
        [self popToViewController:vc animated:animated];
        return YES;
    }
    
    return NO;
}
/*!
 *  获得当前导航器显示的视图
 *
 *  @param ClassName 要获取的视图的名称
 *
 *  @return 成功返回对应的对象，失败返回nil;
 */
-(instancetype)getCurrentViewControllerClass:(NSString *)ClassName{
    Class classObj = NSClassFromString(ClassName);
    NSArray * szArray =  self.viewControllers;
    for (id vc in szArray) {
        if([vc isMemberOfClass:classObj])
        {
            return vc;
        }
    }
    return nil;
}

@end
