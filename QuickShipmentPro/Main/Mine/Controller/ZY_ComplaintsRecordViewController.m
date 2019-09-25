//
//  ZY_ComplaintsRecordViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/13.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_ComplaintsRecordViewController.h"
#import "ZY_ComplaintsRecordModel.h"
#import "ZY_ComplaintsRecordCell.h"
static  NSString *complaintsRecordCellID = @"complaintsRecordCellID";

@interface ZY_ComplaintsRecordViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *collectionView;
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(assign,nonatomic)NSInteger nextPage;
@end

@implementation ZY_ComplaintsRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"投诉记录";
    self.nextPage = 1;
    [self loadComplaintsRecordDatas:YES];
    [self.view addSubview:self.collectionView];
    WeakSelf(self);
    [self.collectionView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        weakself.nextPage = 1;
        [weakself loadComplaintsRecordDatas:YES];

    }];
    [self.collectionView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        weakself.nextPage = pageIndex+1;
        [weakself loadComplaintsRecordDatas:NO];
    }];
}
#pragma mark----请求数据
- (void)loadComplaintsRecordDatas:(BOOL)isRef{
    
    WeakSelf(self);
    if (isRef) {
        [weakself showHud];
        [self.dataArray removeAllObjects];
    }
    NSString *incidStr = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YINCID]];
    NSString *nextPage = [NSString stringWithFormat:@"%ld",weakself.nextPage];
    NSDictionary *params = @{@"incNumber":incidStr,@"pageNumber":nextPage,@"pageSize":@"10"};
    [[ZYNetworkHelper shareHttpManager] requsetWithUrl:[ApiConfig zy_ComplaintsRecordList_URL] withParams:params withCacheType:ZYClientRequestCacheDataIgnore withRequestType:ZYNetworkTypePost withResult:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        [weakself hidHud];
        if (responseObject) {
        
            ZY_Network_Model *network_Model = [ZY_Network_Model mj_objectWithKeyValues:responseObject];
            
            if (network_Model.code == 1) {
                
                if (network_Model.totalpage == 0) {
                    
                    [EasyEmptyView showEmptyInView:weakself.collectionView item:^EasyEmptyPart *{
                        return [EasyEmptyPart shared].setImageName(@"emptyimage").setTitle(@"暂无派件!");
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
                    network_Model.data = [ZY_ComplaintsRecordModel mj_objectArrayWithKeyValuesArray:network_Model.data];
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
#pragma mark----------区间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    CGFloat spaceX = FitSize(12.0f);
    CGFloat spaceH = FitSize(40.0f);
    return UIEdgeInsetsMake(0.0f,spaceX,spaceH,spaceX);
}
#pragma mark----------cell尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(KSCREEN_WIDTH - FitSize(24.0f),FitSize(204.0f));
}
#pragma mark----------cell间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.0f;
}
#pragma mark------自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZY_ComplaintsRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:complaintsRecordCellID forIndexPath:indexPath];
    
    ZY_ComplaintsRecordModel *model = self.dataArray[indexPath.row];
    cell.complaintsRecordObj = model;
    
    return cell;
}

- (void)calendarAction:(UIButton *)sender{
    
//    ZYPickerDateView *pickerView =[[ZYPickerDateView alloc]initWithFrame:CGRectMake(0.0, 0.0f, KSCREEN_WIDTH, KSCREEN_HEIGHT)];
//    [self.view addSubview:pickerView];
//    pickerView.selectedBlock = ^(NSString * selectedDate){
//        
//        NSLog(@"%@",selectedDate);
//        
//    };
    
    
}
#pragma mark----懒加载
- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        CGFloat originY = SAFEAREATOP_HEIGHT;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0f,originY, KSCREEN_WIDTH,KSCREEN_HEIGHT - originY) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        
        [_collectionView registerClass:[ZY_ComplaintsRecordCell class] forCellWithReuseIdentifier:complaintsRecordCellID];
        
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
