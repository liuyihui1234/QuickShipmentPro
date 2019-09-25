//
//  ZYJGGView.h
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/6/24.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYJGGView : UIView
@property (nonatomic,strong)NSArray *dataSource;
@property(copy,nonatomic)void(^selectedButtonClickBlock)(UIButton *sender);
@end

NS_ASSUME_NONNULL_END
