//
//  ZY_PickUpViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//


static  NSString *pickUpListCellID = @"pickUpListCellID";
#import "ZY_PickUpViewController.h"
#import "ZY_PickUpModel.h"
#import "ZY_PickUpListCell.h"
#import "ZYPrintPopView.h"
#import "ZYTemplate.h"
@interface ZY_PickUpViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger nextPage;
@end

@implementation ZY_PickUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [TIMER_SERVICE_INSTANCE start];
    self.navigationItem.title = @"待取件订单";
    [self createLocationUI];
    self.nextPage = 1;
    [self loadPickUpPieceListDatas:YES];

    
    [self.view addSubview:self.collectionView];
    WeakSelf(self);
    
    [self.collectionView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        weakself.nextPage = 1;
        [weakself loadPickUpPieceListDatas:YES];
        
    }];
    [self.collectionView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        weakself.nextPage = pageIndex+1;
        [weakself loadPickUpPieceListDatas:NO];
    }];
    
    [self printOrderResult];
}
#pragma mark----请求数据
- (void)loadPickUpPieceListDatas:(BOOL)isRef{
    
    WeakSelf(self);
    if (isRef) {
        [weakself showHud];
        [self.dataArray removeAllObjects];
    }
    NSString *numberStr = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YUSERNUMBERID]];
    NSString *nextPage = [NSString stringWithFormat:@"%ld",weakself.nextPage];
    NSDictionary *params = @{@"acceptid":@"41010401001",@"pageNum":nextPage,@"pageSize":@"10"};
   
    [[ZYNetworkHelper shareHttpManager] requsetWithUrl:[ApiConfig zy_PickUpPieceList_URL] withParams:params withCacheType:ZYClientRequestCacheDataIgnore withRequestType:ZYNetworkTypePost withResult:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        [weakself hidHud];
        if (responseObject) {
            
            ZY_Network_Model *network_Model = [ZY_Network_Model mj_objectWithKeyValues:responseObject];
           // NSSLog(@"--------==========%@",responseObject);
            if (network_Model.code == 1) {
                
                if (network_Model.totalpage == 0) {
                    [weakself.collectionView endFooterNoMoreData];
                    [EasyEmptyView showEmptyInView:weakself.collectionView item:^EasyEmptyPart *{
                        return [EasyEmptyPart shared].setImageName(@"emptyimage").setTitle(@"暂无待取件订单!");
                    } config:^EasyEmptyConfig *{
                        return [EasyEmptyConfig shared].setTitleColor([UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f]).setBgColor([UIColor clearColor]).setScrollVerticalEnable(NO);
                        
                    } callback:^(EasyEmptyView *view, UIButton *button, callbackType callbackType) {
                        
                        // [EasyEmptyView hiddenEmptyView:emptyV];
                    }];
                }
                else if (weakself.nextPage > network_Model.totalpage) {
                    
                    [weakself.collectionView endFooterNoMoreData];
                }
                else{
                    [weakself.collectionView endFooterRefresh];
                    network_Model.data = [ZY_PickUpModel mj_objectArrayWithKeyValuesArray:network_Model.data];
                    [weakself.dataArray addObjectsFromArray:network_Model.data];
                    [weakself.collectionView reloadData];
                }
            }
            else{
                
                [weakself showToastMessage:network_Model.msg];
            }
        }
    }];
}
#pragma mark------创建主模块部分
- (void)createLocationUI{
    WeakSelf(self);
    UIView *locationBGView = [[UIView alloc]init];
    locationBGView.backgroundColor = [UIColor chains_colorWithHexString:@"#fff7d9" alpha:1.0f];
    [self.view addSubview:locationBGView];
    [locationBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.view);
        make.top.mas_equalTo(SAFEAREATOP_HEIGHT);
        make.height.mas_equalTo(FitSize(30.0f));
    }];
    
    NSString *titleSting = [NSString stringWithFormat:@"  当前位置：%@",@"中国郑州市郑东新区永平路"];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = ZYFontSize(11.0f);
    titleLabel.textColor = [UIColor chains_colorWithHexString:@"#b35e17" alpha:1.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:titleSting];
    /**
     添加图片到指定的位置
     */
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = [UIImage imageNamed:@"managerimg"];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0,-FitSize(3.0f),FitSize(9.0f),FitSize(11.0f));
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    
    titleLabel.attributedText = attriStr;
    
    [locationBGView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(locationBGView);
        make.left.mas_equalTo(FitSize(15.0f));
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(30.0f));
        
    }];
}
#pragma mark----------cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
#pragma mark------自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZY_PickUpListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:pickUpListCellID forIndexPath:indexPath];
    
    ZY_PickUpModel *model = self.dataArray[indexPath.row];
     model.timeInterval = (arc4random() % 5000) + TIMER_SERVICE_INSTANCE.timeInterval;
    cell.pickUpListObj = model;
    WeakSelf(self);
    cell.customButtonBlock = ^(NSInteger senderTag) {
        //tag 1000 定位 2000修改信息 3000 确定取件
        if (senderTag == 2000) {
            
    
        
        }
        else{
            
            ZYPrintPopView *alertView = [[ZYPrintPopView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
           
            alertView.sureActionClickBlock = ^(UIButton * _Nonnull sender) {
            
                [weakself judgeBluetoothStatus];
                
            };
            
            [alertView show];
        }
    
        NSLog(@"-------------%ld",senderTag);
    };
    return cell;
}
#pragma mark-----判断蓝牙状态
- (void)judgeBluetoothStatus{
    
    WeakSelf(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        if ([[PTDispatcher share] getBluetoothStatus]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                //打印
                [[PTDispatcher share] sendData:[ZYTemplate printShenTongTemplate]];
              
            });
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
             
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先连接打印机!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
              
                [alertVC addAction:action];
                [weakself presentViewController:alertVC animated:YES completion:nil];
                
            });
        }
    });
    
}
#pragma mark----打印订单
- (void)printOrderResult{
    WeakSelf(self);
    //数据发送成功
//    [[PTDispatcher share] whenSendSuccess:^(NSNumber *number) {
//        // NSSLog(@"send data success == %@", number);
//        [weakself showToastMessage:@"数据发送成功，准备断开"];
//
//        [[PTDispatcher share] unconnectPrinter:[[PTDispatcher share] printerConnected]];
//
//    }];
    //数据发送失败
    [[PTDispatcher share] whenSendFailure:^{
       // NSSLog(@"send data fail");
        //  [weakself hidHud];
        [weakself showToastMessage:@"数据发送失败!"];
    }];

    //打印进度
    [[PTDispatcher share] whenSendProgressUpdate:^(NSNumber *number) {
        NSLog(@"send progress:%@", number);
    }];
    
}
#pragma mark----懒加载
- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        CGFloat originY = SAFEAREATOP_HEIGHT + FitSize(30.0f);
        CGFloat spaceH = FitSize(15.0f);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(KSCREEN_WIDTH-FitSize(24.0f),FitSize(180.0f));
        flowLayout.sectionInset = UIEdgeInsetsMake(spaceH,FitSize(12.0f),spaceH, FitSize(12.0f));
        flowLayout.minimumLineSpacing = spaceH;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0f,originY, KSCREEN_WIDTH,KSCREEN_HEIGHT - originY) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        [_collectionView registerClass:[ZY_PickUpListCell class] forCellWithReuseIdentifier:pickUpListCellID];
    }
    
    return _collectionView;
}
- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}


@end
