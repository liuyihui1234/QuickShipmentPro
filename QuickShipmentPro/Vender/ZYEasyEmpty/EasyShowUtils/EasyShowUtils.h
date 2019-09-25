//
//  EasyShowUtils.h
//  ArtMoFangProject
//
//  Created by 云创数字 on 2018/6/6.
//  Copyright © 2018年 云创数字. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 是否为空
#define ISEMPTY_S(_v) (_v == nil || _v.length == 0)

// .h
#define easyShowView_singleton_interface  + (instancetype)shared ;
// .m
#define easyShowView_singleton_implementation(class) \
static class *_showInstance; \
+ (id)allocWithZone:(struct _NSZone *)zone { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_showInstance = [super allocWithZone:zone]; \
}); \
return _showInstance; \
} \
+ (instancetype)shared { \
if (nil == _showInstance) { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_showInstance = [[class alloc] init]; \
}); \
} \
return _showInstance; \
} \
- (id)copyWithZone:(NSZone *)zone{ \
return _showInstance; \
} \
- (id)mutableCopyWithZone:(NSZone *)zone{ \
return _showInstance; \
} \

@interface EasyShowUtils : NSObject
+ (CGSize)textWidthWithStirng:(NSString *)string font:(UIFont *)font maxWidth:(CGFloat)maxWidth ;

+ (UIViewController *)easyShowViewTopViewController ;

+ (UIImage *)imageWithColor:(UIColor *)color ;
@end
