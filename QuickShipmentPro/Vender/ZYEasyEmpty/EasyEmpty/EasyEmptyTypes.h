//
//  EasyEmptyTypes.h
//  ArtMoFangProject
//
//  Created by 云创数字 on 2018/6/6.
//  Copyright © 2018年 云创数字. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , callbackType) {
    callbackTypeBgView   = 0,
    callbackTypeButton_1 = 1,
    callbackTypeButton_2 = 2,
};

//typedef NS_ENUM(NSUInteger , emptyViewType) {
//    emptyViewTypeLoding ,
//    emptyViewTypeNoData ,
//    emptyViewTypeNetError ,
////    emptyViewTypeCustom ,
//};

@class EasyEmptyView ;

typedef void (^emptyViewCallback)(EasyEmptyView *view , UIButton *button , callbackType callbackType);



@interface EasyEmptyTypes : NSObject
@end
