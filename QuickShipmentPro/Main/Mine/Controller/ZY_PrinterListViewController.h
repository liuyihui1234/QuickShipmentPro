//
//  ZY_PrinterListViewController.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/1.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZY_PrinterListViewController : ZY_BaseViewController
@property(nonatomic,copy)void(^connectPrinterFucBlock)(NSString *printerName);
@end

NS_ASSUME_NONNULL_END
