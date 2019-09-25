//
//  ZY_MineViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/6/19.
//  Copyright © 2019 飞之翼. All rights reserved.
//
static  NSString *mineMessageHeaderViewID = @"mineMessageHeaderViewID";
static  NSString *mineMessageCellID = @"mineMessageCellID";
static  NSString *mineFucListCellID = @"mineFucListCellID";
static  NSString *mineFooterViewID = @"mineFooterViewID";
#import "ZY_MineViewController.h"
#import "ZY_MineMessageModel.h"
#import "ZY_MineMessageHeaderView.h"
#import "ZY_MineFucListCell.h"
#import "ZY_MineMessageCell.h"
#import "ZY_MineFooterView.h"
#import "ZY_ComplaintsRecordViewController.h"//投诉记录
#import "ZY_RealNameVerViewController.h"
#import "ZY_PrinterListViewController.h"//打印机列表
#import "ZYTemplate.h"
@interface ZY_MineViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *mineCollectionView;
@property(strong,nonatomic)NSMutableArray *firstDatas;
@property(strong,nonatomic)NSMutableArray *secondDatas;
@property(copy,nonatomic)NSString *printerName;
@end

@implementation ZY_MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestDatas];
    self.printerName = @"请连接打印机!";
    NSString *printerStr = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YPRINTERNAMEID]];
    [self setupDispatcherClosure];
    [self PQ_printer:printerStr];
    [self.view addSubview:self.mineCollectionView];
}
#pragma mark----数据源
- (void)requestDatas{
    for (int i = 0; i < 4; i++) {
       ZY_MineMessageModel *model = [[ZY_MineMessageModel alloc]init];
        if(i == 0){
            
            model.iconImage = @"mypoitimg";
            model.title = @"我的积分";
        }
        else if (i == 1){
            model.iconImage = @"gongsirenmian";
            model.title = @"公司任免";
        }
        else if (i == 2){
            model.iconImage = @"mysignmark";
            model.title = @"我的签到";
        }
        else{
            model.iconImage = @"tousujiluimg";
            model.title = @"投诉记录";
        }
        
        [self.firstDatas addObject:model];
    }

    for (int i = 0; i<7; i++) {
        
        ZY_MineMessageModel *model = [[ZY_MineMessageModel alloc]init];
        if (i == 6) {
            model.title = @"版本更新";
            model.versonNum = @"当前版本V1.2.0";
        }
        else{
            model.versonNum = @"";
            if(i == 0){
              model.title = @"实名认证";
                
            }
            else if (i == 1){
              model.title = @"使用说明";
                
            }
            else if (i == 2){
                
              model.title = @"功能介绍";
            }
            else if (i == 3){
                
               model.title = @"客服电话";
            }
            else if (i == 4){
                model.title = @"服务器设置";
                
            }
            else{
             model.title = @"您的留言";
                
            }
            
        }
        
        [self.secondDatas addObject:model];
    }

}
#pragma mark-----区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
}
#pragma mark----------cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 4;
       // return self.firstDatas.count;
    }
    else{
      
        return self.secondDatas.count;
        
    }
}
#pragma mark-----区头尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGFloat height = section == 0 ? FitSize(190.0f) : 0.0f;
    
    return CGSizeMake(KSCREEN_WIDTH,height);
}
#pragma mark-----区尾尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    CGFloat footHeight = section == 1 ? FitSize(133.0f) : 0.0f;
    
    return CGSizeMake(KSCREEN_WIDTH,footHeight);
}
#pragma mark----------cell尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
    
       return CGSizeMake(KSCREEN_WIDTH/4,FitSize(90.0f));
    }
    else{
        
        return CGSizeMake(KSCREEN_WIDTH,FitSize(48.0f));
    }
}
#pragma mark-----自定义区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        WeakSelf(self);
        ZY_MineMessageHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:mineMessageHeaderViewID forIndexPath:indexPath];
        headerView.iconImageUrl = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YPROTRAITPATHID]];;
        headerView.priterName = [NSString stringWithFormat:@"%@",self.printerName];
        
        headerView.scanningPrinterButtonBlock = ^{
            ZY_PrinterListViewController *printerVC = [[ZY_PrinterListViewController alloc]init];
            printerVC.connectPrinterFucBlock = ^(NSString * _Nonnull printerName) {
                weakself.printerName = [NSString stringWithFormat:@"%@",printerName];
                [collectionView reloadData];
                
            };
            
            [weakself.navigationController pushViewController:printerVC animated:YES];
            
        };
        
        return headerView;
    }
    else{
        ZY_MineFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:mineFooterViewID forIndexPath:indexPath];
        footerView.logoutClickBlock = ^(UIButton * _Nonnull sender) {

//            [ZYTools cleanTokenWithKey:FZ_YUSERID];
//            [ZYTools cleanTokenWithKey:FZ_YINCID];
//            [ZYTools cleanTokenWithKey:FZ_YUSERNAMEID];
//            [ZYTools cleanTokenWithKey:FZ_YUSERMOBILEID];
//            [ZYTools cleanTokenWithKey:FZ_YPROTRAITPATHID];
//            ZY_LoginViewController *loginVC = [[ZY_LoginViewController alloc]init];
//            [self presentViewController:loginVC animated:YES completion:nil];
        };
        return footerView;
    }
}
#pragma mark------自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        ZY_MineFucListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mineFucListCellID forIndexPath:indexPath];
        ZY_MineMessageModel *model = self.firstDatas[indexPath.row];
        cell.mineMessageObj = model;
        
        return cell;
    }
    else{
        ZY_MineMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mineMessageCellID forIndexPath:indexPath];
        ZY_MineMessageModel *model = self.secondDatas[indexPath.row];
        cell.mineMessageObj = model;
        return cell;
    }
}
#pragma mark-----cell点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        if (indexPath.row == 3) {

        ZY_ComplaintsRecordViewController *recordVC = [[ZY_ComplaintsRecordViewController alloc]init];
        [self.navigationController pushViewController:recordVC animated:YES];
    
        }}

    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            ZY_RealNameVerViewController *realNameVC = [[ZY_RealNameVerViewController alloc]init];
            [self.navigationController pushViewController:realNameVC animated:YES];
        
        }
        else{
            
            
            
            
        }
    }
}
#pragma mark--------蓝牙模块
- (void)setupDispatcherClosure{
    WeakSelf(self);
    [[PTDispatcher share] whenConnectFailureWithErrorBlock:^(PTConnectError error) {
        
        [weakself hidHud];
        NSString *errorStr;
        
        switch (error) {
            case PTConnectErrorBleTimeout:
                errorStr = @"连接超时";
                break;
                
            case PTConnectErrorBleValidateTimeout:
                errorStr = @"验证超时";
                break;
                
            case PTConnectErrorBleUnknownDevice:
                errorStr = @"未知设备";
                break;
            case PTConnectErrorBleValidateFail:
                errorStr = @"系统错误";
                break;
                
            case PTConnectErrorBleDisvocerServiceTimeout:
                errorStr = @"获取服务超时";
                break;
            case PTConnectErrorWifiTimeout:
                errorStr = @"联网超时";
                break;
                
            case PTConnectErrorWifiSocketError:
                errorStr = @"连接超时";
                break;
            default:
                errorStr = @"";
                break;
        }
        [self showToastMessage:errorStr];
        
    }];
    [[PTDispatcher share] whenUnconnect:^(NSNumber *number, BOOL isActive) {
        [weakself hidHud];
        [PTDispatcher share].sendSuccessBlock = nil;
        [PTDispatcher share].sendFailureBlock = nil;
        [PTDispatcher share].sendProgressBlock = nil;
        [PTDispatcher share].connectFailBlock = nil;
        [PTDispatcher share].connectSuccessBlock = nil;
        [PTDispatcher share].readRSSIBlock = nil;
    }];
}
- (void)PQ_printer:(NSString *)printerName{
    WeakSelf(self);
    //开始扫描蓝牙
    [[PTDispatcher share] scanBluetooth];
    // 获取已发现的所有打印机，每新发现新的打印机或隔三秒调用一次
    [[PTDispatcher share] whenFindAllBluetooth:^(NSMutableArray<PTPrinter *> *printerArray) {
        
        for (PTPrinter *print in printerArray) {
            
            if ([print.name isEqualToString:printerName]) {
                [weakself showHudWithString:@"连接中..."];
            
                //关闭蓝牙搜索
                [[PTDispatcher share] stopScanBluetooth];
                //连接打印机
                [[PTDispatcher share] connectPrinter:print];
            }
        }
    }];
    //连接蓝牙成功后做的事情
    [[PTDispatcher share] whenConnectSuccess:^{
        
        //        NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        //        NSString *path = [docPath stringByAppendingPathComponent:@"shangyitong.plist"];
        //        [NSKeyedArchiver archiveRootObject:self.hyPrinter toFile:path];
       
        [weakself hidHud];
        
        weakself.printerName = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YPRINTERNAMEID]];
        [weakself.mineCollectionView reloadData];
        
        
    }];
    //连接失败的回调
    [[PTDispatcher share] whenConnectFailureWithErrorBlock:^(PTConnectError error) {
       
        [weakself showToastMessage:[NSString stringWithFormat:@"连接失败--%li",(long)error]];
    
    }];
    [[PTDispatcher share] whenUnconnect:^(NSNumber *number, BOOL isActive) {
        [weakself hidHud];
        [PTDispatcher share].sendSuccessBlock = nil;
        [PTDispatcher share].sendFailureBlock = nil;
        [PTDispatcher share].sendProgressBlock = nil;
        [PTDispatcher share].connectFailBlock = nil;
        [PTDispatcher share].connectSuccessBlock = nil;
        [PTDispatcher share].readRSSIBlock = nil;
    }];

}
#pragma mark-- 懒加载
- (UICollectionView *)mineCollectionView{
    
    if (_mineCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = FitSize(1.0f);
        flowLayout.minimumInteritemSpacing = 0.0f;
        flowLayout.sectionInset = UIEdgeInsetsMake(0.0f,0.0f,FitSize(5.0f),0.0f);
        _mineCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0f,SAFEAREATOP_HEIGHT, KSCREEN_WIDTH,KSCREEN_HEIGHT-SAFEAREATOP_HEIGHT-SAFEAREABOTTOM_HEIGHT-FitSize(49.0f)) collectionViewLayout:flowLayout];
        _mineCollectionView.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0];
        _mineCollectionView.delegate = self;
        _mineCollectionView.dataSource = self;
        _mineCollectionView.showsVerticalScrollIndicator = NO;
        _mineCollectionView.scrollsToTop = YES;
        [_mineCollectionView registerClass:[ZY_MineMessageHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:mineMessageHeaderViewID];
        [_mineCollectionView registerClass:[ZY_MineFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:mineFooterViewID];
        [_mineCollectionView registerClass:[ZY_MineMessageCell class] forCellWithReuseIdentifier:mineMessageCellID];
        [_mineCollectionView registerClass:[ZY_MineFucListCell class] forCellWithReuseIdentifier:mineFucListCellID];
    }
    
    return _mineCollectionView;
}
- (NSMutableArray *)firstDatas{
    
    
    if (_firstDatas == nil) {
        _firstDatas = [NSMutableArray arrayWithCapacity:0];
    }
    return _firstDatas;
}
- (NSMutableArray *)secondDatas{
    
    
    if (_secondDatas == nil) {
        _secondDatas = [NSMutableArray arrayWithCapacity:0];
    }
    return _secondDatas;
}
@end
