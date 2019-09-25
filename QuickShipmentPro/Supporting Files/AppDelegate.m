//
//  AppDelegate.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "AppDelegate.h"
#import "ZY_RootNavController.h"
#import "ZY_LoginViewController.h"
#import "ZY_TabBarController.h"
@interface AppDelegate ()
@property(strong,nonatomic)ZY_TabBarController *rootController;
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:KSCREEN_BOUNDS];
    self.window.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0f];
    [self.window makeKeyAndVisible];
    //判断用户是否是第一次安装APP，如果是就显示引导页，否则直接进入主页面
    [self isFirstTimeSetupApp];
    
    return YES;
}
#pragma mark - 判断用户是否是第一次安装APP
- (void)isFirstTimeSetupApp{
    
    // 设置窗口的根控制器
//    _rootController = [[ZY_TabBarController alloc] init];
//    self.window.rootViewController = _rootController;
    ZY_LoginViewController *login_VC = [[ZY_LoginViewController alloc]init];
    ZY_RootNavController *navVC = [[ZY_RootNavController alloc] initWithRootViewController:login_VC];
    self.window.rootViewController = navVC;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
