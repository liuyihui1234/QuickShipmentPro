//
//  ZY_BaseViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseViewController.h"
#import "MBProgressHUD.h"
#import "ZY_LoginViewController.h"
@interface ZY_BaseViewController ()
@property(nonatomic,strong)MBProgressHUD *progressHud;
@property(nonatomic,strong)UIView *emptyView;
@end

@implementation ZY_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0f];
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshToken:) name:@"LoginToken" object:nil];
}
#pragma mark-----懒加载
- (MBProgressHUD *)progressHud{
    
    if (!_progressHud) {
        
        _progressHud = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHud.frame = self.view.bounds;
        _progressHud.minSize = CGSizeMake(FitSize(100.0f),FitSize(100.0f));
        _progressHud.mode = MBProgressHUDModeIndeterminate;
        _progressHud.label.textColor = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
        _progressHud.label.text = @"加载中...";
        _progressHud.bezelView.backgroundColor =
        [UIColor chains_colorWithHexString:kBlackColor alpha:1.0f];
        //设置菊花框为白色
        [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
        [self.view addSubview:_progressHud];
    }
    return _progressHud;
}
/**
 * 显示菊花
 */
- (void)showHud{
    [self.progressHud showAnimated:YES];
    [self.progressHud hideAnimated:YES afterDelay:0.35];
    [self.view bringSubviewToFront:self.progressHud];
}
/**
 * 隐藏菊花
 */
- (void)hidHud{
    
    [self.progressHud hideAnimated:YES];
    [self.view sendSubviewToBack:self.progressHud];
}
/**
 * 定制菊花下方显示字体
 */
- (void)showHudWithString:(NSString *)loadingText{
    
    self.progressHud.label.text = loadingText;
    [self.progressHud showAnimated:YES];
    self.progressHud.bezelView.backgroundColor =
    [UIColor chains_colorWithHexString:kBlackColor alpha:1.0f];
    //设置菊花框为白色
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
    [self.view bringSubviewToFront:self.progressHud];
}
#pragma mark--------提示框
- (void)showToastMessage:(NSString *)message {
    MBProgressHUD *hud = nil;
    if (self.navigationController.view) {
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    } else {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.label.text = message;
    hud.label.font = ZYFontSize(16.0f);
    hud.label.textColor = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
    hud.margin = FitSize(10.0f);
    hud.label.numberOfLines = 0;
    hud.label.textAlignment = NSTextAlignmentCenter;
    [hud setOffset:CGPointMake(0.0f, 0.0f)];
    hud.bezelView.backgroundColor = [UIColor chains_colorWithHexString:kBlackColor alpha:1.0f];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2.0f];
}
- (void)refreshToken:(NSNotification *)noti{
    
    //使用userInfo处理消息
    NSDictionary  *dic = [noti userInfo];
    NSString *info = [dic objectForKey:@"msgcode"];
    [self showToastMessage:info];
    
    //GCD延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //登录界面
        ZY_LoginViewController *login_VC = [[ZY_LoginViewController alloc]init];
        [self presentViewController:login_VC animated:YES completion:nil];
        
    });
    
    
}
- (void)dealloc{
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
