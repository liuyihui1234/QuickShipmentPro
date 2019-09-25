//
//  ZY_LoginViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/28.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_LoginViewController.h"
#import "ZY_UserMesModel.h"
#import "ZY_TabBarController.h"
@interface ZY_LoginViewController ()

@end

@implementation ZY_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawLoginUI];
}
#pragma mark-------登录数据
- (void)requestUserLoginDatas{
    
    UITextField *accountTF = (ZYLoginTextField *)[self.view viewWithTag:300];
    UITextField *passwordTF = (ZYLoginTextField *)[self.view viewWithTag:302];
    
    NSString *accountStr = [NSString stringWithFormat:@"%@",accountTF.text];
    NSString *passwordStr = [NSString stringWithFormat:@"%@",passwordTF.text];
    
    if (accountStr.length == 0) {
        
        [self showToastMessage:@"账号不能为空"];
    }
    else{
        
        if (passwordStr.length == 0) {
            
            [self showToastMessage:@"密码不能为空"];
        }
        else{
            WeakSelf(self);
            [weakself showHudWithString:@"登录中..."];
            NSDictionary *paramsDic = @{@"number":accountStr,@"phone":@"1523636326",@"Password":passwordStr};
            [[ZYNetworkHelper shareHttpManager] requsetWithUrl:[ApiConfig zy_UserLoginAccount_URL] withParams:paramsDic withCacheType:ZYClientRequestCacheDataIgnore withRequestType:ZYNetworkTypePost withResult:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
                [weakself hidHud];
                if (responseObject) {
                    NSSLog(@"==-----%@",responseObject);
                    ZY_Network_Model *network_Model = [ZY_Network_Model mj_objectWithKeyValues:responseObject];
                    if (network_Model.code == 1) {
                        [weakself showToastMessage:network_Model.msg];
                        ZY_UserMesModel *model = [ZY_UserMesModel mj_objectWithKeyValues:network_Model.data];
                        [ZYTools saveToken:model.token withKey:FZ_YTOKEN];
                        [ZYTools saveToken:model.ID withKey:FZ_YUSERID];
                        [ZYTools saveToken:model.incid withKey:FZ_YINCID];
                        [ZYTools saveToken:model.name withKey:FZ_YUSERNAMEID];
                        [ZYTools saveToken:model.mobile withKey:FZ_YUSERMOBILEID];
                        [ZYTools saveToken:model.number withKey:FZ_YUSERNUMBERID];
                        [ZYTools saveToken:model.portraitpath withKey:FZ_YPROTRAITPATHID];
                        ZY_TabBarController *rootController = [[ZY_TabBarController alloc]init];
                        kKeyWindow.rootViewController = rootController;
                    }
                    else{
                        
                        [weakself showToastMessage:network_Model.msg];
                    }
                }
            }];
        }
    }
}
#pragma mark-----创建主模块
- (void)drawLoginUI{
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"logoicon"];
    iconImageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:iconImageView];
    WeakSelf(self);
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.view);
        make.top.mas_equalTo(SAFEAREATOP_HEIGHT + FitSize(28.0f));
        make.height.width.mas_equalTo(FitSize(58.0));
    }];
    NSArray *noImgs=@[@"accounticon",@"telphoneicon",@"passwordiocn"];
    NSArray *placeholders=@[@"账号",@"联系方式",@"密码"];
    
    NSArray *maxLengthS=@[@20,@11,@50];
    __block ZYLoginTextField *customTF;
    [noImgs enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        customTF = [[ZYLoginTextField alloc]init];
        customTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        customTF.font=[UIFont systemFontOfSize:FitSize(14.0f)];
        customTF.leftIconNameStr = noImgs[idx];
        customTF.placeholder = placeholders[idx];
        customTF.tag = idx + 300;
        [weakself.view addSubview:customTF];
        customTF.maxTextLength = [maxLengthS[idx] intValue];
        customTF.isHiddenStar = NO;
        if (idx == 0) {
            
//            NSString *accountNum = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:@"Account"]];
//            customTF.text = accountNum;
            
            customTF.text = @"44010000003";
        }
        else if (idx == 2){
            
            customTF.text = @"123456";
        }
    
        [customTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(iconImageView);
            make.top.equalTo(iconImageView.mas_bottom).offset(FitSize(40.0f) + FitSize(69.0f)*idx);
            make.height.mas_equalTo(FitSize(49.0f));
            make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(80.0f));
        }];
    }];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
    loginButton.layer.cornerRadius = FitSize(24.5f);
    loginButton.titleLabel.font = ZYFontSize(16.0f);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.height.width.equalTo(customTF);
        make.top.equalTo(customTF.mas_bottom).offset(FitSize(24.0f));
        
    }];
}
#pragma mark-------按钮点击事件
- (void)loginButtonAction:(UIButton *)sender{
    
    [self requestUserLoginDatas];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
