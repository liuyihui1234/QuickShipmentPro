//
//  ZY_PrinterListCell.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/1.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PTPrinter;
@interface ZY_PrinterListCell : UICollectionViewCell
@property(strong,nonatomic)PTPrinter *printerObj;
@end

NS_ASSUME_NONNULL_END
