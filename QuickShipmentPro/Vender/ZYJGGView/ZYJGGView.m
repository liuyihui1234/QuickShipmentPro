//
//  ZYJGGView.m
//  ZYSignContractPro
//
//  Created by 飞之翼 on 2019/6/24.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYJGGView.h"

@implementation ZYJGGView

- (instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self) {
    
         self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
- (void)setDataSource:(NSArray *)dataSource{
    WeakSelf(self);
    _dataSource = dataSource;
    //清除所有子控件，根据数据重新布局
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [dataSource enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ZYCustomButton *imageButton = [ZYCustomButton buttonWithType:UIButtonTypeCustom];
        [imageButton setTitleColor:[UIColor chains_colorWithHexString:kDarkColor alpha:1.0f] forState:UIControlStateNormal];
        imageButton.titleLabel.font = ZYFontSize(15.0f);
        imageButton.zy_spacing = FitSize(8.0f);
        [imageButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.zy_buttonType = ZYCustomButtonImageTop;
        //网络图片
        // [btn sd_setImageWithURL:[NSURL URLWithString:obj] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"WechatIMG"]];
        //本地图片
        [imageButton setImage:[UIImage imageNamed:obj[0]] forState:UIControlStateNormal];
        [imageButton setTitle:obj[1] forState:UIControlStateNormal];
        imageButton.tag = idx;
        
        [weakself addSubview:imageButton];
    }];

}
#pragma mark----点击事件
- (void)imageButtonClick:(UIButton *)sender{
    
    if (self.selectedButtonClickBlock) {
        self.selectedButtonClickBlock(sender);
    }
    
}
#pragma mark-----布局
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat spaceH = FitSize(20.0f);
    CGFloat spaceW = FitSize(20.0f);
    CGFloat width = (self.frame.size.width-FitSize(24.0f)-3*spaceW)/4;
    CGFloat height = FitSize(65.0f);
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton *imageButton, NSUInteger idx, BOOL *stop) {
        NSInteger row = idx / 4;
        NSInteger col = idx % 4;
        [imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(FitSize(12.0f) + col *(width+spaceW)));
            make.top.equalTo(@(spaceH +  row *(height+spaceH)));
            make.height.equalTo(@(height));
            make.width.equalTo(@(width));
        }];
        

    }];


}
@end
