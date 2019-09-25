//
//  SystemDefine.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#ifndef SystemDefine_h
#define SystemDefine_h

#ifdef DEBUG
#define NSSLog(format, ...) printf("[%s]    %s  [第 %d 行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSSLog(format, ...)
#endif

//当前设备的iOS版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//屏幕尺寸
#define KSCREEN_BOUNDS       [UIScreen mainScreen].bounds
#define KSCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define WIDTH_SCALE          KSCREEN_WIDTH/375

//适配iPhoneX
// 底部安全高度
#define SAFEAREABOTTOM_HEIGHT  (IPHONE_X == YES ? 34.0f : 0.0f)
//顶部安全高度
#define  SAFEAREATOP_HEIGHT    (IPHONE_X == YES ? 88.0f : 64.0f)
//工具栏高度
#define BEGINPOINTY            (IPHONE_X == YES ? 44.0f : 20.0f)

//位置坐标
#define FitSize(X)    X *WIDTH_SCALE  //适配坐标尺寸

/*********  字体  ***************/
#define ZYFontSize(s) [UIFont fontWithName:@"PingFangSC-Regular" size:FitSize(s)] //这个是9.0以后自带的平方字体

#define kBlackColor          @"#000000" //黑色
#define kWhiteColor          @"FFFfff"  //白色
#define kDarkColor          @"#333333"
#define kThemeColor          @"#c9292e" //主题色
#define kMainBGColor         @"#edf0f7" //底色（灰色）
#define kDarkGrayColor       @"#666666"
#define kBackgroundColor     @"#f0f0f0"
#define kGrayColor           @"#999999"
#define kLineColor           @"#efefef"
#define kLightDarkColor      @"#e4e4e4"


//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;
// KeyWindow
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#endif /* SystemDefine_h */
