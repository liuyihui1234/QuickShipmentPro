//
//  ZY_HaveCollectingViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/12.
//  Copyright © 2019 飞之翼. All rights reserved.
//

static  NSString *haveCollectingListCellID = @"haveCollectingListCellID";
#import "ZY_HaveCollectingViewController.h"
#import "ZY_LoansSettlementModel.h"
#import "ZY_NoPayMentListCell.h"
@interface ZY_HaveCollectingViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)UICollectionView *collectionView;
/**
 选中的数组
 */
@property (nonatomic,strong)NSMutableArray *selectArray;
@end

@implementation ZY_HaveCollectingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestDatas];
    [self.view addSubview:self.collectionView];
    [self drawShoopingCartBottomViewUI];
}
#pragma mark---数据
- (void)requestDatas{
    
    for (int i = 0; i<10; i++) {
        
        ZY_LoansSettlementModel *model = [[ZY_LoansSettlementModel alloc]init];
        model.isSelected = NO;
      
        model.number = @"TT6600039908311";
        model.fromaddress = @"广东省广州市花都区田美村";
        model.fromname = @"张家明";
        model.price = @"120";
        model.fromtel = @"15838348055";
        model.createtime = @"2019.06.11";
        model.buyCount = @"1";
        [self.dataArray addObject:model];
    }
}
#pragma mark-----设置底部操作栏
- (void)drawShoopingCartBottomViewUI{
    
    WeakSelf(self);
    UIView *cusToolBar = [[UIView alloc]init];
    cusToolBar.backgroundColor = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
    [self.view addSubview:cusToolBar];
    
    ZYCustomButton *allSelectButton = [ZYCustomButton buttonWithType:UIButtonTypeCustom];
    [allSelectButton setTitleColor:[UIColor chains_colorWithHexString:kDarkColor alpha:1.0f] forState:UIControlStateNormal];
    allSelectButton.titleLabel.font = ZYFontSize(14.0f);
    allSelectButton.zy_spacing = FitSize(3.0f);
    allSelectButton.tag = 8888;
    [allSelectButton setImage:[UIImage imageNamed:@"paynoseleled"] forState:UIControlStateNormal];
    [allSelectButton setImage:[UIImage imageNamed:@"payseleled"] forState:UIControlStateSelected];
    [allSelectButton setTitle:@"全选" forState:UIControlStateNormal];
    [allSelectButton addTarget:self action:@selector(allSelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    allSelectButton.zy_buttonType = ZYCustomButtonImageLeft;
    //水平左对齐
    allSelectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [cusToolBar addSubview:allSelectButton];
    
    UILabel *moneyLabel = [[UILabel alloc]init];
    moneyLabel.font = ZYFontSize(14.0f);
    moneyLabel.textColor = [UIColor chains_colorWithHexString:kBlackColor alpha:1.0f];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.attributedText = [self setPriceFontWithPrice:@"￥0.00"];
    moneyLabel.tag = 10000;
    [cusToolBar addSubview:moneyLabel];
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.backgroundColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
    [customButton setTitle:@"结算(0)" forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f] forState:UIControlStateNormal];
    customButton.titleLabel.font = ZYFontSize(14.0f);
    customButton.layer.cornerRadius = FitSize(15.0f);
    customButton.tag = 6666;
    [customButton addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cusToolBar addSubview:customButton];
    
    
    [cusToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.width.equalTo(weakself.view);
        make.height.equalTo(@(FitSize(49.0f)+SAFEAREABOTTOM_HEIGHT));
    }];
    [allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(FitSize(30.0f)));
        make.top.equalTo(cusToolBar);
        make.height.equalTo(@(FitSize(49.0f)));
        make.width.equalTo(@(FitSize(50.0f)));
    }];
    [customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-FitSize(12.0f)));
        make.top.equalTo(@(FitSize(9.5f)));
        make.width.equalTo(@(FitSize(75.0f)));
        make.height.equalTo(@(FitSize(30.0f)));
    }];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(customButton.mas_left).offset(-FitSize(10.0f));
        make.top.height.equalTo(customButton);
        make.width.lessThanOrEqualTo(@(FitSize(180.0f)));
        
    }];
}
#pragma mark----------cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
#pragma mark------自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZY_NoPayMentListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:haveCollectingListCellID forIndexPath:indexPath];
    
    ZY_LoansSettlementModel *goodsModel = self.dataArray[indexPath.row];
    cell.locansSettlementObj = goodsModel;
    
    WeakSelf(self);
    cell.selectedGoodsButtonBlock = ^(BOOL isClick) {
        
        goodsModel.isSelected = isClick;
        
        if (isClick) {//选中
            
            [weakself.selectArray addObject:goodsModel];
        } else {//取消选中
            [weakself.selectArray removeObject:goodsModel];
        }
        
        [weakself judgeIsAllSelect];
        [weakself countPrice];
    };
    
    return cell;
}
#pragma mark-----结算按钮事件
- (void)customButtonAction:(UIButton *)sender{
    //订单确认
    
    
    
}
#pragma mark----全选按钮事件
- (void)allSelectButtonAction:(ZYCustomButton *)sender{
    
    sender.selected = !sender.selected;
    for (ZY_LoansSettlementModel *goodsModel in self.selectArray) {
        goodsModel.isSelected = NO;
    }
    [self.selectArray removeAllObjects];
    if (sender.selected) {
        
        for (ZY_LoansSettlementModel *model in self.dataArray) {
            model.isSelected = YES;
            [self.selectArray addObject:model];
        }
    }
    else {//取消选中
        NSLog(@"取消全选");
        for (ZY_LoansSettlementModel *storeModel in self.dataArray) {
            storeModel.isSelected = NO;
        }
    }
    
    [self.collectionView reloadData];
    [self countPrice];
}
/**
 是否全选
 */
- (void)judgeIsAllSelect {
    UIButton *customButton = (UIButton *)[self.view viewWithTag:8888];
    //如果购物车总商品数量 等于 选中的商品数量, 即表示全选了
    if (self.dataArray.count == self.selectArray.count) {
        customButton.selected = YES;
        
    } else {
        customButton.selected = NO;
        
    }
}
/**
 计算价格
 */
- (void)countPrice{
    double totlePrice = 0.0;
    NSInteger totalNumber = 0;
    for (ZY_LoansSettlementModel *goodsModel in self.selectArray) {
        double price = [goodsModel.price doubleValue];
        NSInteger number = [goodsModel.buyCount integerValue];
        totlePrice += price;
        totalNumber += number;
    }
    UIButton *customButton = (UIButton *)[self.view viewWithTag:6666];
    [customButton setTitle:[NSString stringWithFormat:@"结算(%ld)",totalNumber] forState:UIControlStateNormal];
    UILabel *moneyLabel = (UILabel *)[self.view viewWithTag:10000];
    moneyLabel.attributedText = [self setPriceFontWithPrice:[NSString stringWithFormat:@"￥%.2f",totlePrice]];
}
#pragma mark----设置字体
- (NSMutableAttributedString *)setPriceFontWithPrice:(NSString *)price{
    
    NSString *totalStr = [NSString stringWithFormat:@"合计 %@",price];
    NSMutableAttributedString *string = [totalStr zy_changeFontArr:@[ZYFontSize(14.0f)] ColorArr:@[kThemeColor] TotalString:totalStr SubStringArray:@[price] Alignment:0 Space:0.0f];
    
    return string;
}
#pragma mark----懒加载
- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        CGFloat originY = SAFEAREATOP_HEIGHT + FitSize(40.0f);
        CGFloat spaceH = FitSize(15.0f);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(KSCREEN_WIDTH-FitSize(24.0f),FitSize(165.0f));
        flowLayout.sectionInset = UIEdgeInsetsMake(spaceH,FitSize(12.0f),spaceH, FitSize(12.0f));
        flowLayout.minimumLineSpacing = spaceH;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0f,0.0f, KSCREEN_WIDTH,KSCREEN_HEIGHT - originY - FitSize(49.0f) - SAFEAREABOTTOM_HEIGHT) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        [_collectionView registerClass:[ZY_NoPayMentListCell class] forCellWithReuseIdentifier:haveCollectingListCellID];
    }
    
    return _collectionView;
}
- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (NSMutableArray *)selectArray{
    
    if (_selectArray == nil) {
        
        _selectArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectArray;
}

@end
