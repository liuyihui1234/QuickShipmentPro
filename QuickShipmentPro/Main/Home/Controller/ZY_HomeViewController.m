//
//  ZY_HomeViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_HomeViewController.h"
#import "ZY_HomeSliderModel.h"
#import "ZY_HomeUserInfoModel.h"
#import "ZY_HomeUserInfoView.h"
#import "ZYJGGView.h"
#import "ZY_MessageCenterViewController.h"//消息中心
#import "ZY_HomeUserInfoViewController.h"//设置中心
#import "ZY_ReceiveOrderViewController.h"//接单
#import "ZY_PickUpViewController.h"//取件
#import "ZY_AddresseeViewController.h"//收件
#import "ZY_SendPieceViewController.h"//派件
#import "ZY_MoneyManagerViewController.h"//资金管理
#import "ZY_MyPostViewController.h"//我的驿站
#import "ZY_SearchTypeViewController.h"//查询
#import "ZY_PayManagerViewController.h"//支付


@interface ZY_HomeViewController ()<UINavigationControllerDelegate>
@property(strong,nonatomic)ZY_HomeUserInfoView *messgeBGView;
@end

@implementation ZY_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    [self createHomeMainUI];
    [self requestSliderDatas];
}
#pragma mark-----轮播图数据
- (void)requestSliderDatas{
    WeakSelf(self);
    NSDictionary *params = @{@"id":@"2"};
    [[ZYNetworkHelper shareHttpManager] requsetWithUrl:[ApiConfig zy_HomeCarouselShow_URL] withParams:params withCacheType:ZYClientRequestCacheDataIgnore withRequestType:ZYNetworkTypePost withResult:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        
        if (responseObject) {
            
            ZY_Network_Model *network_Model = [ZY_Network_Model mj_objectWithKeyValues:responseObject];
            
            if (network_Model.code == 1) {
                NSArray *dataArr = [ZY_HomeSliderModel mj_objectArrayWithKeyValuesArray:network_Model.data];
                [dataArr enumerateObjectsUsingBlock:^(ZY_HomeSliderModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx == 0) {
                        
                        UIImageView *bannerImage = (UIImageView *)[weakself.view viewWithTag:1000];
                        [bannerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",obj.picpath]]];
                        *stop = YES;
                    }
                }];
            }
            else{
                
                [weakself showToastMessage:network_Model.msg];
            }
        }
    }];
}
#pragma mark-----创建主模块
- (void)createHomeMainUI{
    
    ZY_HomeUserInfoModel *model = [[ZY_HomeUserInfoModel alloc]init];
    model.name = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YUSERNAMEID]];
    model.portraitpath = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YPROTRAITPATHID]];
    model.tel = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YUSERMOBILEID]];
    model.time = @"6月11日  12:40";
    
    WeakSelf(self);
    UIImageView *noticeImageView = [[UIImageView alloc]init];
    noticeImageView.tag = 1000;
    noticeImageView.userInteractionEnabled = YES;
    [self.view addSubview:noticeImageView];
    
    ZY_HomeUserInfoView *messgeBGView = [[ZY_HomeUserInfoView alloc]init];
    messgeBGView.homeUserInfoObj = model;
    self.messgeBGView = messgeBGView;
    messgeBGView.editUserInfoGestureRecognizerBlock = ^{
      //编辑
        ZY_HomeUserInfoViewController *userInfoVC = [[ZY_HomeUserInfoViewController alloc]init];
        userInfoVC.changeUserInfoClickBlock = ^{
            ZY_HomeUserInfoModel *model = [[ZY_HomeUserInfoModel alloc]init];
            model.name = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YUSERNAMEID]];
            model.portraitpath = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YPROTRAITPATHID]];
            model.tel = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YUSERMOBILEID]];
            model.time = @"6月11日  12:40";
            [weakself.messgeBGView refreshUserInfoDatasWithInfo:model];
        };

        [weakself.navigationController pushViewController:userInfoVC animated:YES];
    };
    messgeBGView.locationButtonClickBlock = ^(UIButton * _Nonnull sender) {
    
        
    };
    [self.view addSubview:messgeBGView];
    [noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(BEGINPOINTY);
        make.left.width.equalTo(weakself.view);
        make.height.mas_equalTo(FitSize(217.0f));
        
    }];
    [messgeBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(noticeImageView.mas_bottom).offset(-FitSize(35.0f));
        make.centerX.equalTo(weakself.view);
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
        make.height.mas_equalTo(FitSize(129.0f));
        
    }];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = ZYFontSize(17.0f);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"快8速递";
    [noticeImageView addSubview:titleLabel];
    //消息按钮
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageButton setImage:[UIImage imageNamed:@"nomessage"] forState:UIControlStateNormal];
    [messageButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateSelected];
    [messageButton addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    [noticeImageView addSubview:messageButton];
    
    CGFloat cusHeight = FitSize(44.0f);
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.top.equalTo(noticeImageView);
        make.height.mas_equalTo(cusHeight);
        make.width.mas_equalTo(FitSize(160.0f));
    }];
    [messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.equalTo(noticeImageView);
        make.height.width.mas_equalTo(cusHeight);
    }];
    ZYJGGView *jggView = [[ZYJGGView alloc]init];
    jggView.dataSource = @[@[@"jiedanimg",@"接单"],@[@"qujianimg",@"取件"],@[@"xiadanimg",@"收件"],@[@"paidanimg",@"派件"],@[@"managerimg",@"资金管理"],@[@"mypostimg",@"我的驿站"],@[@"chajianimg",@"查询"],@[@"zhifuimg",@"支付"]];
    jggView.selectedButtonClickBlock = ^(UIButton * _Nonnull sender) {
        
        if(sender.tag == 0){
            //接单
             ZY_ReceiveOrderViewController *receiveOrderVC = [[ZY_ReceiveOrderViewController alloc]init];
             [weakself.navigationController pushViewController:receiveOrderVC animated:YES];
        }
        else if (sender.tag == 1){
            //取件
            ZY_PickUpViewController *pickUPVC = [[ZY_PickUpViewController alloc]init];
            [weakself.navigationController pushViewController:pickUPVC animated:YES];
        }
        else if (sender.tag == 2){
            //收件
            ZY_AddresseeViewController *addresseeVC = [[ZY_AddresseeViewController alloc]init];
            [weakself.navigationController pushViewController:addresseeVC animated:YES];
        }
        else if (sender.tag == 3){
            //派件
            ZY_SendPieceViewController *sendPieceVC = [[ZY_SendPieceViewController alloc]init];
            [weakself.navigationController pushViewController:sendPieceVC animated:YES];
        }
        else if (sender.tag == 4){
            //资金管理
            ZY_MoneyManagerViewController *moneyManagerVC = [[ZY_MoneyManagerViewController alloc]init];
            [weakself.navigationController pushViewController:moneyManagerVC animated:YES];
        }
        else if (sender.tag == 5){
            //我的驿站
            ZY_MyPostViewController *mypostVC = [[ZY_MyPostViewController alloc]init];
            [weakself.navigationController pushViewController:mypostVC animated:YES];
        }
        else if (sender.tag == 6){
            //查询
            ZY_SearchTypeViewController *searchVC = [[ZY_SearchTypeViewController alloc]init];
            [weakself.navigationController pushViewController:searchVC animated:YES];
        }
        else{
            //支付
            ZY_PayManagerViewController *payManagreVC = [[ZY_PayManagerViewController alloc]init];
            [self.navigationController pushViewController:payManagreVC animated:YES];
        }
    };
    [self.view addSubview:jggView];
    
    [jggView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.width.equalTo(messgeBGView);
        make.top.equalTo(messgeBGView.mas_bottom).offset(FitSize(20.0f));
        make.height.mas_equalTo(FitSize(186.0f));
    }];
    
}
#pragma mark----消息按钮事件
- (void)messageAction:(UIButton *)sender{

    sender.selected = !sender.selected;
        ZY_MessageCenterViewController *messageVC = [[ZY_MessageCenterViewController alloc]init];
        [self.navigationController pushViewController:messageVC animated:YES];
}
#pragma mark ---- < UINavigationControllerDelegate >
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
- (void)dealloc {
    self.navigationController.delegate = nil;
}

@end
