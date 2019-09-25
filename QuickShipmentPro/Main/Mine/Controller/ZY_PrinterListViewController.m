//
//  ZY_PrinterListViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/1.
//  Copyright © 2019 飞之翼. All rights reserved.
//

static  NSString *printerListCellID = @"printerListCellID";

#import "ZY_PrinterListViewController.h"
#import "ZY_PrinterListCell.h"
@interface ZY_PrinterListViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *printerCollectionView;
@property(strong,nonatomic)NSMutableArray *printerDatas;
@property(copy,nonatomic)NSString *printerName;

@end

@implementation ZY_PrinterListViewController

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [[PTDispatcher share] stopScanBluetooth];
    [[PTDispatcher share] whenConnectSuccess:nil];
    [[PTDispatcher share] whenConnectFailureWithErrorBlock:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"打印机列表";
    [self.view addSubview:self.printerCollectionView];
    [self judgeBluetoothStatus];
    [self requestPrinter];
}
#pragma mark-----判断蓝牙状态
- (void)judgeBluetoothStatus{
    
    WeakSelf(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if ([[PTDispatcher share] getBluetoothStatus]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showHudWithString:@"扫描中..."];
                [[PTDispatcher share] scanBluetooth];
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself showToastMessage:@"请先打开手机蓝牙"];
            });
        }
    });
}
#pragma mark----设置打印
- (void)requestPrinter{
    WeakSelf(self);
    [[PTDispatcher share] setupPeripheralFilter:^BOOL(CBPeripheral *peripheral, NSDictionary<NSString *,id> *advertisementData, NSNumber *RSSI) {
        if (peripheral.name) {
           // NSSLog(@"-=======%@",peripheral.name);
        }
        else{
            
            return NO;
        }
        NSNumber *connectable = advertisementData[CBAdvertisementDataIsConnectable];
        if (connectable) {
            if (!connectable.boolValue) {
                return NO;
            }
        }
        return YES;
    }];
    [[PTDispatcher share] whenFindAllBluetooth:^(NSMutableArray<PTPrinter *> *printerArray) {
        
        [weakself hidHud];
        weakself.printerDatas = printerArray;
        [weakself.printerCollectionView reloadData];
        
    }];
    [[PTDispatcher share] whenConnectSuccess:^{
        [weakself hidHud];
        [[PTDispatcher share] stopScanBluetooth];
        [weakself showToastMessage:@"连接成功!"];
        [ZYTools saveToken:weakself.printerName withKey:FZ_YPRINTERNAMEID];
        if (weakself.connectPrinterFucBlock) {
            weakself.connectPrinterFucBlock(weakself.printerName);
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    
    }];
    [[PTDispatcher share] whenConnectFailureWithErrorBlock:^(PTConnectError error) {
        
        if (error) {
            
            [weakself showToastMessage:@"蓝牙扫描失败!"];
        }
    }];
}
#pragma mark----------cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

     return self.printerDatas.count;
}
#pragma mark------自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZY_PrinterListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:printerListCellID forIndexPath:indexPath];
    PTPrinter *printerModel = self.printerDatas[indexPath.row];
    cell.printerObj = printerModel;
   
    return cell;
}
#pragma mark-----cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PTPrinter *priter = self.printerDatas[indexPath.row];
    [self showHudWithString:@"连接中..."];
    [[PTDispatcher share] connectPrinter:priter];
    self.printerName = [NSString stringWithFormat:@"%@",priter.name];

}
#pragma mark-- 懒加载
- (UICollectionView *)printerCollectionView{
    
    if (_printerCollectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = FitSize(1.0f);
        flowLayout.minimumInteritemSpacing = 0.0f;
        flowLayout.sectionInset = UIEdgeInsetsMake(0.0f,0.0f,FitSize(5.0f),0.0f);
        flowLayout.itemSize = CGSizeMake(KSCREEN_WIDTH, FitSize(50.0f));
        _printerCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0f,SAFEAREATOP_HEIGHT, KSCREEN_WIDTH,KSCREEN_HEIGHT-SAFEAREATOP_HEIGHT) collectionViewLayout:flowLayout];
        _printerCollectionView.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0];
        _printerCollectionView.delegate = self;
        _printerCollectionView.dataSource = self;
        _printerCollectionView.showsVerticalScrollIndicator = NO;
        [_printerCollectionView registerClass:[ZY_PrinterListCell class] forCellWithReuseIdentifier:printerListCellID];
    }
    
    return _printerCollectionView;
}
- (NSMutableArray *)printerDatas{
    
    if (_printerDatas == nil) {
        _printerDatas = [NSMutableArray arrayWithCapacity:0];
    }
    return _printerDatas;
}

@end
