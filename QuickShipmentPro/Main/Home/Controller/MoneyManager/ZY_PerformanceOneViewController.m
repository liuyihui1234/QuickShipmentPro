//
//  ZY_PerformanceOneViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/30.
//  Copyright © 2019 飞之翼. All rights reserved.
//

static  NSString *myPerformanceCellID = @"myPerformanceCellID";
#import "ZY_PerformanceOneViewController.h"
#import "ZY_MyPerformanceModel.h"
#import "ZY_MyPerformanceCell.h"
@interface ZY_PerformanceOneViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger nextPage;
@end

@implementation ZY_PerformanceOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nextPage = 1;
    [self loadPerformanceOneListDatas:YES];
    [self.view addSubview:self.collectionView];
    WeakSelf(self);
    
    [self.collectionView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        weakself.nextPage = 1;
        [weakself loadPerformanceOneListDatas:YES];
        
    }];
    [self.collectionView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        weakself.nextPage = pageIndex+1;
        [weakself loadPerformanceOneListDatas:NO];
    }];

}
#pragma mark----请求数据
- (void)loadPerformanceOneListDatas:(BOOL)isRef{
    
    WeakSelf(self);
    if (isRef) {
        [weakself showHud];
        [self.dataArray removeAllObjects];
    }
    NSString *numberStr = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YUSERNUMBERID]];
    NSString *nextPage = [NSString stringWithFormat:@"%ld",weakself.nextPage];
    NSDictionary *params = @{@"createUserId":@"41110000001",@"pageNum":nextPage,@"pageSize":@"10"};
    
    [[ZYNetworkHelper shareHttpManager] requsetWithUrl:[ApiConfig zy_MyReceiptOrderList_URL] withParams:params withCacheType:ZYClientRequestCacheDataIgnore withRequestType:ZYNetworkTypePost withResult:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        [weakself hidHud];
        if (responseObject) {
            
            ZY_Network_Model *network_Model = [ZY_Network_Model mj_objectWithKeyValues:responseObject];
           // NSSLog(@"--------==========%@",responseObject);
           
            if (network_Model.code == 1) {
                
                if (network_Model.totalpage == 0) {
                    [weakself.collectionView endFooterNoMoreData];
                    [EasyEmptyView showEmptyInView:weakself.collectionView item:^EasyEmptyPart *{
                        return [EasyEmptyPart shared].setImageName(@"emptyimage").setTitle(@"暂无收件!");
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
                    network_Model.data = [ZY_MyPerformanceModel mj_objectArrayWithKeyValuesArray:network_Model.data];
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
#pragma mark----------cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
#pragma mark------自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZY_MyPerformanceCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:myPerformanceCellID forIndexPath:indexPath];
    
    ZY_MyPerformanceModel *model = self.dataArray[indexPath.row];
    cell.myperformanceObj = model;
    
    return cell;
}

#pragma mark----懒加载
- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        CGFloat originY = SAFEAREATOP_HEIGHT + FitSize(40.0f);
        CGFloat spaceH = FitSize(15.0f);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(KSCREEN_WIDTH-FitSize(24.0f),FitSize(125.0f));
        flowLayout.sectionInset = UIEdgeInsetsMake(spaceH,FitSize(12.0f),spaceH, FitSize(12.0f));
        flowLayout.minimumLineSpacing = spaceH;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0f,0.0f, KSCREEN_WIDTH,KSCREEN_HEIGHT - originY) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        [_collectionView registerClass:[ZY_MyPerformanceCell class] forCellWithReuseIdentifier:myPerformanceCellID];
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
