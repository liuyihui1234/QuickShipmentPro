//
//  ZYPickerDateView.h
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/6/26.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYPickerDateView : UIView
@property (nonatomic, assign) NSString * selectedDate;
@property (nonatomic, copy) void (^selectedBlock) (NSString * selectedDate);
@end

NS_ASSUME_NONNULL_END
