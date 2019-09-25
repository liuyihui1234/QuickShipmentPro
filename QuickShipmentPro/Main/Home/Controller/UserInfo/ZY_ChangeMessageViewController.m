//
//  ZY_ChangeMessageViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_ChangeMessageViewController.h"

@interface ZY_ChangeMessageViewController ()

@end

@implementation ZY_ChangeMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createCustonNav];
    [self drawChangeMessageUI];
}
#pragma mark-----自定义返回按钮
- (void)createCustonNav{
    
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backWhiteImg"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = itemleft;
}
#pragma mark-----主模块
- (void)drawChangeMessageUI{
    
    WeakSelf(self);
    self.title = self.titleString;
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.view);
        make.top.mas_equalTo(SAFEAREATOP_HEIGHT);
        make.height.mas_equalTo(FitSize(49.0f));
    }];
    CGFloat spaceX = FitSize(15.0f);
    UITextField *customTextfiled = [[UITextField alloc]init];
    [customTextfiled becomeFirstResponder];
    customTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    customTextfiled.font = [UIFont systemFontOfSize:FitSize(13.0f)];
    customTextfiled.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    customTextfiled.text = [NSString stringWithFormat:@"%@",self.textString];
    customTextfiled.tag = 10000;
    [bgView addSubview:customTextfiled];
    
    [customTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(spaceX);
        make.right.mas_equalTo(-spaceX);
        make.top.height.equalTo(bgView);
        
    }];
}
- (void)backButtonAction:(UIButton *)sender{
    
    UITextField *customTextfiled = (UITextField *)[self.view viewWithTag:10000];
    NSString *custonStr = [NSString stringWithFormat:@"%@",customTextfiled.text];
    
    if (custonStr.length == 0) {
        NSString *message;
        if ([self.titleString isEqualToString:@"修改名字"]) {
            
            message = @"名字不能为空";
        }
        else{
            
            message = @"手机号不能为空";
        }
        
        [self showToastMessage:message];
    }
    else{
        if ([self.titleString isEqualToString:@"修改名字"]) {
            
            [self changeUserInfoWithInfo:custonStr];
        }
        else{
            if ([ZYTools isMobileNumber:custonStr] == NO) {
                
                [self showToastMessage:@"请输入正确的手机号"];
                
            }
            else{
                
                [self changeUserInfoWithInfo:custonStr];
            }
        }
    }
}

- (void)changeUserInfoWithInfo:(NSString *)info{
    
    if (self.changeUserInfoClickBlock) {
        self.changeUserInfoClickBlock(info);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
