//
//  ZY_PrinterListCell.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/1.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_PrinterListCell.h"
@interface ZY_PrinterListCell()
@property(strong,nonatomic)UILabel *printerLabel;
@end

@implementation ZY_PrinterListCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.printerLabel];
        
    }
    return self;
}
#pragma mark----赋值
- (void)setPrinterObj:(PTPrinter *)printerObj{
    
    self.printerLabel.text = [NSString stringWithFormat:@"%@",printerObj.name];
    
}
#pragma mark-------布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    WeakSelf(self);
    CGFloat spaceX = FitSize(15.0f);
    [self.printerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.top.height.equalTo(weakself);
        make.width.mas_equalTo(FitSize(180.0f));
        
        
    }];
 
    
}

#pragma mark-----懒加载
- (UILabel *)printerLabel{
    
    if (_printerLabel == nil) {
        
        _printerLabel = [[UILabel alloc]init];
        _printerLabel.font = ZYFontSize(13.0f);
        _printerLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
       
    }
    
    return _printerLabel;
}

@end
