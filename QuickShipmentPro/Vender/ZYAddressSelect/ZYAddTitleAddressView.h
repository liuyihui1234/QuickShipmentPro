//
//  ZYAddTitleAddressView.h
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/2.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  ZYAddTitleAddressViewDelegate <NSObject>
-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID;
@end
@interface ZYAddTitleAddressView : UIView
@property(nonatomic,assign)id<ZYAddTitleAddressViewDelegate>addressDelegate;
@property(nonatomic,assign)NSInteger userID;
@property(nonatomic,assign)NSUInteger defaultHeight;
@property(nonatomic,assign)CGFloat titleScrollViewH;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)UIView *addAddressView;
@property(nonatomic,strong)NSMutableArray *titleMarr;
@property(nonatomic,strong)NSMutableArray *tableViewMarr;
-(UIView *)initAddressView;
-(void)setupTitleScrollView;
-(void)setupContentScrollView;
-(void)setupAllTitle:(NSInteger)selectId;
-(void)addAnimate;
@end

NS_ASSUME_NONNULL_END
