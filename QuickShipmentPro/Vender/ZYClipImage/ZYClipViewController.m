//
//  ZYClipViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYClipViewController.h"
#import "ZYClipImageView.h"
@interface ZYClipViewController ()
@property (nonatomic, strong)ZYClipImageView *clipImageView;
@end

@implementation ZYClipViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // 从相机界面跳转会默认隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self drawNavUI];
    [self.view addSubview:self.clipImageView];
    self.clipImageView.clipImage = self.needClipImage;
}
#pragma mark----设置导航
- (void)drawNavUI{
    
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backWhiteImg"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"searchaddress"] style:UIBarButtonItemStylePlain target:self action:@selector(sureAction:)];
    self.navigationItem.rightBarButtonItem = itemRight;
}
- (void)backButtonAction:(UIButton *)sender{
    // 取消裁剪
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)sureAction:(UIBarButtonItem *)item{
    // 裁剪成功
    UIImage *clipedImage = [self.clipImageView getClipedImage];
    if([self.delegate respondsToSelector:@selector(didSuccessClipImage:)]){
        [self.delegate didSuccessClipImage:clipedImage];
    }
}
#pragma mark -- getter
- (ZYClipImageView *)clipImageView{
    if(_clipImageView == nil){
        _clipImageView = [ZYClipImageView initWithFrame:CGRectMake(0.0f,0.0f,KSCREEN_WIDTH,KSCREEN_HEIGHT-SAFEAREATOP_HEIGHT)];
         _clipImageView.contentMode = UIViewContentModeScaleAspectFit;
        _clipImageView.midLineColor = [UIColor redColor];
        _clipImageView.clipType = ClipAreaViewTypeRect;
    }
    return _clipImageView;
}
@end
