//
//  ZYMidLineView.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define MID_LINE_WIDTH FitSize(30)
#define MID_LINE_HEIGHT FitSize(3)
#define MID_LINE_INVISIBLE FitSize(25)

typedef NS_ENUM(NSInteger, MidLineViewType)
{
    MidLineViewTypeTop = 0,
    MidLineViewTypeLeft,
    MidLineViewTypeBottom,
    MidLineViewTypeRight,
};
@interface ZYMidLineView : UIView
@property (nonatomic, assign) CGFloat midLineWidth; /**< 能看到的宽度*/
@property (nonatomic, assign) CGFloat midLineHeight; /**< 能看到的高度*/
@property (nonatomic, assign) MidLineViewType midLineType;
@property (nonatomic, strong) UIColor *midLineColor;

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)heigth type:(MidLineViewType)type;
@end

NS_ASSUME_NONNULL_END
