//
//  EasyEmptyPart.h
//  ArtMoFangProject
//
//  Created by 云创数字 on 2018/6/6.
//  Copyright © 2018年 云创数字. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyEmptyPart : NSObject
@property (nonatomic,strong)NSString *title ;                 //标题
@property (nonatomic,strong)NSString *subtitle ;              //副标题
@property (nonatomic,strong)NSString *imageName ;             //图片名称
@property (nonatomic,strong)NSArray<NSString *> *buttonArray ;//下面需要的按钮

+ (instancetype)shared ;
- (EasyEmptyPart *(^)(NSString *))setTitle ;
- (EasyEmptyPart *(^)(NSString *))setSubtitle ;
- (EasyEmptyPart *(^)(NSString *))setImageName ;
- (EasyEmptyPart *(^)(NSArray<NSString *> *))setButtonArray ;


+ (instancetype)itemWithTitle:(NSString *)title ;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle ;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName ;
+ (instancetype)itemWithTitle:(NSString *)title subtitle:(NSString *)subtitle imageName:(NSString *)imageName buttonArray:(NSArray *)buttonArray ;
@end
