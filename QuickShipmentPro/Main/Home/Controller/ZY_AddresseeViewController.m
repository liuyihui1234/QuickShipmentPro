//
//  ZY_AddresseeViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_AddresseeViewController.h"
#import "ZY_AddressSelectedListViewController.h"
@interface ZY_AddresseeViewController ()
@property(strong,nonatomic)UIScrollView *mainScrollview;
@end

@implementation ZY_AddresseeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"收件";
    [self createLocationUI];
    [self.view addSubview:self.mainScrollview];
    [self createMainUI];
    [self createToolBarUI];
}
#pragma mark------创建定位部分
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
    attchImage.image = [UIImage imageNamed:@"currentlocimg"];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0,-FitSize(2.0f),FitSize(9.0f),FitSize(11.0f));
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
#pragma mark----创建主模块
- (void)createMainUI{
    WeakSelf(self);
    CGFloat spaceX = FitSize(12.0f);
    UIView *firstBGView = [[UIView alloc]init];
    firstBGView.backgroundColor = [UIColor chains_colorWithHexString:@"#ffffff" alpha:0.3f];
    [self.mainScrollview addSubview:firstBGView];
    [firstBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.view);
        make.top.mas_equalTo(FitSize(20.0f));
        make.height.mas_equalTo(FitSize(212.0f));
    }];
    
    UIView *secodBGView = [[UIView alloc]init];
    secodBGView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollview addSubview:secodBGView];
    [secodBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.mainScrollview);
        make.top.equalTo(firstBGView.mas_bottom).offset(FitSize(26.0f));
        make.height.mas_equalTo(FitSize(554.0f));
    }];
    
    [self.mainScrollview mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(secodBGView.mas_bottom).offset(FitSize(20.0f));
    }];

    UIView *addressBGView = [[UIView alloc]init];
    addressBGView.backgroundColor = [UIColor whiteColor];
    [firstBGView addSubview:addressBGView];
    [addressBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstBGView);
        make.left.mas_equalTo(spaceX);
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
        make.height.mas_equalTo(FitSize(120.0f));
    }];
    
    UIImageView *leftImageView = [[UIImageView alloc]init];
    leftImageView.image = [UIImage imageNamed:@"banner"];
    [addressBGView addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.top.mas_equalTo(FitSize(19.0f));
        make.width.mas_equalTo(FitSize(17.0f));
        make.height.mas_equalTo(FitSize(82.0f));
    }];
    
    NSArray *messageArr = @[@"寄件人信息",@"收件人信息"];
    [messageArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *cusTextField = [[UITextField alloc]init];
        cusTextField.font = ZYFontSize(15.0f);
        cusTextField.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        cusTextField.placeholder = [NSString stringWithFormat:@"%@",obj];
        cusTextField.tag = idx + 200;
        cusTextField.rightViewMode = UITextFieldViewModeAlways;
        [addressBGView addSubview:cusTextField];

        UIButton *editArressButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f,0.0f, FitSize(40.0f),FitSize(30.0f))];
        [editArressButton setImage:[UIImage imageNamed:@"jishibenimg"] forState:UIControlStateNormal];
        editArressButton.tag = idx + 1000;
        [editArressButton addTarget:self action:@selector(editArressButton:) forControlEvents:UIControlEventTouchUpInside];
        cusTextField.rightView = editArressButton;
        
        [cusTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftImageView.mas_right).offset(FitSize(17.0f));
            make.top.mas_equalTo(FitSize(12.0f)+idx*FitSize(64.0f));
            make.right.mas_equalTo(-FitSize(5.0f));
            make.height.mas_equalTo(FitSize(30.0f));
        }];
        if (idx == 0) {
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor chains_colorWithHexString:@"#cccccc" alpha:1.0f];
            [addressBGView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.width.equalTo(cusTextField);
                make.top.equalTo(cusTextField.mas_bottom).offset(FitSize(19.0f));
                make.height.mas_equalTo(FitSize(0.5f));
            }];
        }
    }];
    
    NSString *titleSting = @" 上门取件时间";
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = ZYFontSize(12.0f);
    titleLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:titleSting];
    // 添加图片到指定的位置
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = [UIImage imageNamed:@"shangmenqujian"];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0.0f,-FitSize(4.0f),FitSize(17.0f),FitSize(17.0f));
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    titleLabel.attributedText = attriStr;
    [firstBGView addSubview:titleLabel];
    
    UITextField *reserveTextField = [[UITextField alloc]init];
    reserveTextField.font = ZYFontSize(13.0f);
    reserveTextField.backgroundColor = [UIColor chains_colorWithHexString:@"#f7f7f7" alpha:1.0f];
    reserveTextField.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    reserveTextField.placeholder = @"请预约上门取件时间";
    reserveTextField.tag = 1000;
    reserveTextField.leftViewMode = UITextFieldViewModeAlways;
    [firstBGView addSubview:reserveTextField];
    UIView *leftLineView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, spaceX, FitSize(33.0f))];
    leftLineView.backgroundColor = [UIColor clearColor];
    reserveTextField.leftView = leftLineView;
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(spaceX);
        make.top.equalTo(addressBGView.mas_bottom).offset(FitSize(22.0f));
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(36.0f));
        make.height.mas_equalTo(FitSize(17.0f));
    }];
    [reserveTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(FitSize(12.0f));
        make.height.mas_equalTo(FitSize(33.0f));
     
    }];

    //****************第二部分**************//
    UILabel *messTitleLabel = [[UILabel alloc]init];
    messTitleLabel.font = ZYFontSize(12.0f);
    messTitleLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    messTitleLabel.textAlignment = NSTextAlignmentCenter;
    messTitleLabel.text = @"完善更多信息，更精准估价";
    [secodBGView addSubview:messTitleLabel];
    
    UIView *topLineView = [[UIView alloc]init];
    topLineView.backgroundColor = [UIColor chains_colorWithHexString:kLineColor alpha:1.0f];
    [secodBGView addSubview:topLineView];
    
    [messTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(secodBGView);
        make.height.mas_equalTo(FitSize(43.0f));
    }];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(secodBGView);
        make.top.equalTo(messTitleLabel.mas_bottom);
        make.height.mas_equalTo(FitSize(1.0f));
    }];
    
    CGFloat cusHeight = FitSize(59.0f);
    ZYChoiceGoodsInfoView *goodsMesView = [[ZYChoiceGoodsInfoView alloc]init];
    [goodsMesView changeShowMessgeWithImage:@"tuojiwu" title:@"托寄物信息" message:@"文件/kg"];
    [secodBGView addSubview:goodsMesView];

    ZYChoiceGoodsInfoView *payTypeView = [[ZYChoiceGoodsInfoView alloc]init];
    [payTypeView changeShowMessgeWithImage:@"fukuanfangshi" title:@"付款方式" message:@"寄付现结"];
    [secodBGView addSubview:payTypeView];
    
    ZYChoiceGoodsInfoView *collMoneyView = [[ZYChoiceGoodsInfoView alloc]init];
    [collMoneyView changeShowMessgeWithImage:@"managerimg" title:@"代收货款" message:@"0.00"];
    [secodBGView addSubview:collMoneyView];
    
    ZYChoiceGoodsInfoView *valuationView = [[ZYChoiceGoodsInfoView alloc]init];
    [valuationView changeShowMessgeWithImage:@"baojiaimg" title:@"保价" message:@"无"];
    [secodBGView addSubview:valuationView];
    
    ZYChoiceGoodsInfoView *addValueView = [[ZYChoiceGoodsInfoView alloc]init];
    [addValueView changeShowMessgeWithImage:@"zengzhifuwu" title:@"增值服务" message:@"无"];
    [secodBGView addSubview:addValueView];
    
    ZYChoiceGoodsInfoView *remarkView = [[ZYChoiceGoodsInfoView alloc]init];
    [remarkView changeShowMessgeWithImage:@"beizhuimg" title:@"备注" message:@"无"];
    [secodBGView addSubview:remarkView];

    [goodsMesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.top.equalTo(topLineView.mas_bottom).offset(FitSize(13.0f));
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
        make.height.mas_equalTo(cusHeight);
    }];
    [payTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(goodsMesView);
        make.top.equalTo(goodsMesView.mas_bottom).offset(FitSize(17.0f));
        make.width.mas_equalTo(FitSize(160.0f));
    }];
    [collMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(payTypeView);
        make.right.mas_equalTo(-spaceX);
        
    }];
    
    [valuationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(payTypeView);
        make.top.equalTo(payTypeView.mas_bottom).offset(FitSize(17.0f));
        
    }];
    
    [addValueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(valuationView);
        make.right.equalTo(collMoneyView);
        
    }];
    [remarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(valuationView);
        make.top.equalTo(valuationView.mas_bottom).offset(FitSize(17.0f));
        
    }];
    
    NSString *desSting = @" 货物描述";
    UILabel *describeLabel = [[UILabel alloc]init];
    describeLabel.font = ZYFontSize(12.0f);
    describeLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    describeLabel.text = desSting;
    
    NSMutableAttributedString * describeattriStr = [[NSMutableAttributedString alloc] initWithString:desSting];
    // 添加图片到指定的位置
    NSTextAttachment *describeattchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    describeattchImage.image = [UIImage imageNamed:@"huowubiaoshu"];
    // 设置图片大小
    describeattchImage.bounds = CGRectMake(0.0f,-FitSize(4.0f),FitSize(17.0f),FitSize(17.0f));
    NSAttributedString *describestringImage = [NSAttributedString attributedStringWithAttachment:describeattchImage];
    [describeattriStr insertAttributedString:describestringImage atIndex:0];
    describeLabel.attributedText = describeattriStr;
    [secodBGView addSubview:describeLabel];
    
    UIView *imageBGView = [[UIView alloc]init];
    imageBGView.backgroundColor = [UIColor chains_colorWithHexString:@"#f7f7f7" alpha:1.0f];
    [secodBGView addSubview:imageBGView];

    [describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(remarkView);
        make.top.equalTo(remarkView.mas_bottom).offset(FitSize(20.0f));
        make.height.mas_equalTo(FitSize(15.0f));
        make.width.mas_equalTo(FitSize(220.0f));
    }];
    
    [imageBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.top.equalTo(describeLabel.mas_bottom).offset(FitSize(7.0f));
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
        make.height.mas_equalTo(FitSize(146.0f));

    }];
    
    UILabel *addImageShowLabel = [[UILabel alloc]init];
    addImageShowLabel.font = ZYFontSize(13.0f);
    addImageShowLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    addImageShowLabel.text = @"添加货的照片";
    [imageBGView addSubview:addImageShowLabel];
    [addImageShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(spaceX);
        make.top.equalTo(imageBGView);
        make.height.mas_equalTo(FitSize(30.0f));
        make.width.mas_equalTo(FitSize(120.0f));
    }];
    
    NSArray *photoArray = @[@"addvideo",@"addvideo"];
    [photoArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [photoButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",obj]] forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [imageBGView addSubview:photoButton];
        
        [photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(spaceX + idx *FitSize(82.0f));
            make.bottom.mas_equalTo(-spaceX);
            make.height.mas_equalTo(FitSize(58.0f));
            make.width.mas_equalTo(FitSize(62.0f));
        
        }];
    }];
}
#pragma mark-----创建底部栏
- (void)createToolBarUI{
 
    CGFloat cusWidth = KSCREEN_WIDTH/2;
    WeakSelf(self);
    UIView *cusToolBar = [[UIView alloc]init];
    cusToolBar.backgroundColor = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
    [self.view addSubview:cusToolBar];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.backgroundColor = [UIColor chains_colorWithHexString:kThemeColor alpha:1.0f];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f] forState:UIControlStateNormal];
    sureButton.titleLabel.font = ZYFontSize(19.0f);
    [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cusToolBar addSubview:sureButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = [UIColor chains_colorWithHexString:kLightDarkColor  alpha:1.0f];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = ZYFontSize(19.0f);
    [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cusToolBar addSubview:cancelButton];
    [cusToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.width.equalTo(weakself.view);
        make.height.equalTo(@(FitSize(49.0f)+SAFEAREABOTTOM_HEIGHT));
    }];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(cusToolBar);
        make.height.mas_equalTo(FitSize(49.0f));
        make.width.mas_equalTo(cusWidth);
    }];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(sureButton);
        make.left.equalTo(sureButton.mas_right);
    }];
    
    
}
#pragma mark----编辑地址事件
- (void)editArressButton:(UIButton *)sender{
    
    ZY_AddressSelectedListViewController *addressVC = [[ZY_AddressSelectedListViewController alloc]init];
    addressVC.selectedType = sender.tag;
    
    
    [self.navigationController pushViewController:addressVC animated:YES];
    
}
- (void)photoButtonAction:(UIButton *)sender{
    
    
    
}
#pragma mark----确定事件
- (void)sureButtonAction:(UIButton *)sender{
    
    
    
    
}
#pragma mark----取消事件
- (void)cancelButtonAction:(UIButton *)sender{
    
    
}
#pragma mark-----布局
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    WeakSelf(self);
    [self.mainScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.width.equalTo(weakself.view);
        make.top.mas_equalTo(SAFEAREATOP_HEIGHT+FitSize(30.0f));
        make.height.mas_equalTo(KSCREEN_HEIGHT-SAFEAREATOP_HEIGHT-FitSize(79.0f)-SAFEAREABOTTOM_HEIGHT);
        
    }];
  
}
#pragma mark---------懒加载
- (UIScrollView *)mainScrollview{
    
    if (_mainScrollview == nil) {
        
        _mainScrollview = [[UIScrollView alloc]init];
        _mainScrollview.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0f];
        _mainScrollview.showsVerticalScrollIndicator = NO;
        _mainScrollview.pagingEnabled = YES;
        
    }
    
    return _mainScrollview;
}
@end
