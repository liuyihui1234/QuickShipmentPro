//
//  ZY_FreightSearchViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/3.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_FreightSearchViewController.h"

@interface ZY_FreightSearchViewController ()<UITextFieldDelegate>
@property(strong,nonatomic)UIScrollView *searchScrollview;

@end

@implementation ZY_FreightSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"运费及时效查询";
    [self.view addSubview:self.searchScrollview];
    [self drawFreightSearchUI];
}
#pragma mark---创建主模块
- (void)drawFreightSearchUI{
    WeakSelf(self);
    NSArray *addressDatas = @[@[@"原寄地",@"请选择原寄地"],@[@"目的地",@"请选择原寄地后再选择目的地"],@[@"重量(kg)",@""]];
    __block UIView *firstBGView;
    [addressDatas enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        firstBGView = [[UIView alloc]init];
        firstBGView.backgroundColor = [UIColor whiteColor];
        [weakself.searchScrollview addSubview:firstBGView];
        [firstBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(weakself.searchScrollview);
            make.top.mas_equalTo(idx *FitSize(41.0f));
            make.height.mas_equalTo(FitSize(40.0f));
        }];
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = ZYFontSize(13.0f);
        titleLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        titleLabel.text = [NSString stringWithFormat:@"%@",obj[0]];
        [firstBGView addSubview:titleLabel];
        
        UITextField *cusTextField = [[UITextField alloc]init];
        cusTextField.font = ZYFontSize(13.0f);
        cusTextField.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        cusTextField.placeholder = [NSString stringWithFormat:@"%@",obj[1]];
        cusTextField.tag = idx + 300;
        cusTextField.rightViewMode = UITextFieldViewModeAlways;
        
        UIImageView *arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(20.0f),FitSize(20.0f))];
        arrowImage.contentMode = UIViewContentModeRight;
        arrowImage.image = [UIImage imageNamed:@"mineArrow"];
        cusTextField.rightView = arrowImage;
    
        [firstBGView addSubview:cusTextField];
    
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FitSize(20.0f));
            make.top.height.equalTo(firstBGView);
            make.width.mas_equalTo(FitSize(60.0f));
        }];
        [cusTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right);
            make.top.height.equalTo(firstBGView);
            make.right.mas_equalTo(-FitSize(20.0f));
        }];
    }];
    UIView *secondBGView = [[UIView alloc]init];
    secondBGView.backgroundColor = [UIColor whiteColor];
    [weakself.searchScrollview addSubview:secondBGView];
    [secondBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.searchScrollview);
        make.top.equalTo(firstBGView.mas_bottom).offset(FitSize(1.0f));
        make.height.mas_equalTo(FitSize(80.0f));
    }];
    
    UILabel *volumeLabel = [[UILabel alloc]init];
    volumeLabel.font = ZYFontSize(13.0f);
    volumeLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    volumeLabel.text = @"体积";
    volumeLabel.textAlignment = NSTextAlignmentCenter;
    [secondBGView addSubview:volumeLabel];
    
    UIView *leftLineView = [[UIView alloc]init];
    leftLineView.backgroundColor = [UIColor chains_colorWithHexString:kLineColor alpha:1.0f];
    [secondBGView addSubview:leftLineView];
    
    UITextField *lengthTF = [[UITextField alloc]init];
    lengthTF.font = ZYFontSize(13.0f);
    lengthTF.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    lengthTF.leftViewMode = UITextFieldViewModeAlways;
    lengthTF.rightViewMode = UITextFieldViewModeAlways;
    
    UILabel *lengthLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(15.0f), FitSize(40.0f))];
    lengthLabel.font = ZYFontSize(13.0f);
    lengthLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    lengthLabel.text = @"长";
    lengthTF.leftView = lengthLabel;
    
    UILabel *lengthRightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(20.0f),FitSize(40.0f))];
    lengthRightLabel.font = ZYFontSize(12.0f);
    lengthRightLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    lengthRightLabel.text = @"cm";
    lengthTF.rightView = lengthRightLabel;
    
    [secondBGView addSubview:lengthTF];

    UIView *centerLineView = [[UIView alloc]init];
    centerLineView.backgroundColor = [UIColor chains_colorWithHexString:kLineColor alpha:1.0f];
    [secondBGView addSubview:centerLineView];
    
    UITextField *wideTF = [[UITextField alloc]init];
    wideTF.font = ZYFontSize(13.0f);
    wideTF.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    wideTF.leftViewMode = UITextFieldViewModeAlways;
    wideTF.rightViewMode = UITextFieldViewModeAlways;
    
    UILabel *wideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(15.0f), FitSize(40.0f))];
    wideLabel.font = ZYFontSize(13.0f);
    wideLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    wideLabel.text = @"宽";
    wideTF.leftView = wideLabel;
    
    UILabel *wideRightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(20.0f),FitSize(40.0f))];
    wideRightLabel.font = ZYFontSize(12.0f);
    wideRightLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    wideRightLabel.text = @"cm";
    wideTF.rightView = wideRightLabel;
    
    [secondBGView addSubview:wideTF];
    
    UITextField *heightTF = [[UITextField alloc]init];
    heightTF.font = ZYFontSize(13.0f);
    heightTF.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    heightTF.leftViewMode = UITextFieldViewModeAlways;
    heightTF.rightViewMode = UITextFieldViewModeAlways;
    
    UILabel *heightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(15.0f), FitSize(40.0f))];
    heightLabel.font = ZYFontSize(13.0f);
    heightLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    heightLabel.text = @"高";
    heightTF.leftView = heightLabel;
    
    UILabel *heightRightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(20.0f),FitSize(40.0f))];
    heightRightLabel.font = ZYFontSize(12.0f);
    heightRightLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    heightRightLabel.text = @"cm";
    heightTF.rightView = heightRightLabel;
    
    [secondBGView addSubview:heightTF];
    
    [volumeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FitSize(10.0f));
        make.top.equalTo(secondBGView);
        make.height.width.mas_equalTo(FitSize(40.0f));
    }];
    
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(volumeLabel.mas_right);
        make.top.height.equalTo(secondBGView);
        make.width.mas_equalTo(FitSize(1.0f));
    }];

    [lengthTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(leftLineView.mas_right).offset(FitSize(5.0f));
        make.top.height.equalTo(volumeLabel);
        make.width.mas_equalTo(FitSize(80.0f));
    }];
    [centerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lengthTF.mas_right).offset(FitSize(5.0f));
        make.top.height.equalTo(lengthTF);
        make.width.mas_equalTo(FitSize(1.0f));
    }];
    
    [wideTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(centerLineView.mas_right).offset(FitSize(10.0f));
        make.top.height.width.equalTo(lengthTF);
    }];
    [heightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.equalTo(lengthTF);
        make.top.equalTo(lengthTF.mas_bottom);
    }];
   
    UIView *thidBGView = [[UIView alloc]init];
    thidBGView .backgroundColor = [UIColor whiteColor];
    [weakself.searchScrollview addSubview:thidBGView];
    [thidBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.searchScrollview);
        make.top.equalTo(secondBGView.mas_bottom).offset(FitSize(1.0f));
        make.height.mas_equalTo(FitSize(40.0f));
    }];
    
    UILabel *timeTitleLabel = [[UILabel alloc]init];
    timeTitleLabel.font = ZYFontSize(13.0f);
    timeTitleLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    timeTitleLabel.text = @"寄件时间";
    [thidBGView addSubview:timeTitleLabel];
    
    UITextField *timeTextField = [[UITextField alloc]init];
    timeTextField.font = ZYFontSize(13.0f);
    timeTextField.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    timeTextField.placeholder = @"请选择寄件时间";
    timeTextField.tag = 500;
    timeTextField.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *arrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(20.0f),FitSize(20.0f))];
    arrowImage.contentMode = UIViewContentModeRight;
    arrowImage.image = [UIImage imageNamed:@"mineArrow"];
    timeTextField.rightView = arrowImage;
    
    [thidBGView addSubview:timeTextField];
    
    [timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FitSize(20.0f));
        make.top.height.equalTo(thidBGView);
        make.width.mas_equalTo(FitSize(60.0f));
    }];
    [timeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeTitleLabel.mas_right);
        make.top.height.equalTo(thidBGView);
        make.right.mas_equalTo(-FitSize(20.0f));
    }];
    
    UIButton *weightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weightButton setTitle:@"为什么要同时输入体积和重量?" forState:UIControlStateNormal];
    [weightButton setTitleColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] forState:UIControlStateNormal];
    weightButton.titleLabel.font = ZYFontSize(12.0f);
    [weightButton addTarget:self action:@selector(weightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchScrollview addSubview:weightButton];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.backgroundColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    [searchButton setTitle:@"查询" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f] forState:UIControlStateNormal];
    searchButton.titleLabel.font = ZYFontSize(13.0f);
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.layer.cornerRadius = FitSize(5.0f);
    [self.searchScrollview addSubview:searchButton];
    [weightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(timeTextField);
        make.top.equalTo(thidBGView.mas_bottom);
        make.width.mas_equalTo(FitSize(170.0f));
        make.height.mas_equalTo(FitSize(40.0f));
    }];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.searchScrollview);
        make.top.equalTo(weightButton.mas_bottom);
        make.height.mas_equalTo(FitSize(40.0f));
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(60.0f));
    }];
    
    UIView *fourthBGView = [[UIView alloc]init];
    fourthBGView.backgroundColor = [UIColor whiteColor];
    [weakself.searchScrollview addSubview:fourthBGView];
    [fourthBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.searchScrollview);
        make.top.equalTo(searchButton.mas_bottom).offset(FitSize(10.0f));
        make.height.mas_equalTo(FitSize(40.0f));
    }];
    
    UITextField *searchTextField = [[UITextField alloc]init];
    searchTextField.font = ZYFontSize(13.0f);
    searchTextField.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    searchTextField.text = @"运费查询其他说明";
    searchTextField.tag = 1000;
    searchTextField.rightViewMode = UITextFieldViewModeAlways;
    searchTextField.delegate = self;
    UIImageView *searchArrowImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(20.0f),FitSize(20.0f))];
    searchArrowImage.contentMode = UIViewContentModeRight;
    searchArrowImage.image = [UIImage imageNamed:@"mineArrow"];
    searchTextField.rightView = searchArrowImage;
    
    [fourthBGView addSubview:searchTextField];
    
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FitSize(20.0f));
        make.top.height.equalTo(fourthBGView);
        make.right.mas_equalTo(-FitSize(20.0f));
    }];
    
    UITextView *feeTextView = [[UITextView alloc]init];
    feeTextView.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
   
    NSString *content = @"2019年秋季学期中央党校（国家行政学院）中青年干部培训班3日上午在中央党校开班。中共中央总书记、国家主席、中央军委主席习近平在开班式上发表重要讲话强调，广大干部特别是年轻干部要经受严格的思想淬炼、政治历练、实践锻炼，发扬斗争精神，增强斗争本领，为实现“两个一百年”奋斗目标、实现中华民族伟大复兴的中国梦而顽强奋斗。中共中央政治局常委、中央书记处书记王沪宁出席开班式。";
    
   NSMutableAttributedString *string = [content zy_changeFontArr:@[ZYFontSize(13.0f)] ColorArr:@[kGrayColor] TotalString:content SubStringArray:@[content] Alignment:1 Space:FitSize(3.0f)];

    feeTextView.attributedText = string;
    
    feeTextView.textContainerInset = UIEdgeInsetsMake(FitSize(10.0f),FitSize(10.0f),FitSize(10.0f),FitSize(10.0f));
    //允许编辑
    feeTextView.editable = YES;
    feeTextView.tag = 10000;
    feeTextView.hidden = YES;
    feeTextView.backgroundColor = [UIColor whiteColor];
    [self.searchScrollview addSubview:feeTextView];
    [feeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.searchScrollview);
        make.top.equalTo(fourthBGView.mas_bottom).offset(FitSize(1.0f));
        make.height.mas_equalTo(FitSize(200.0f));
    
    }];
    [self.searchScrollview mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(feeTextView.mas_bottom).offset(FitSize(40.0f));
        
    }];
  
}
#pragma mark-----重量事件
- (void)weightButtonAction:(UIButton *)sender{
    
}
#pragma mark-----查询事件
- (void)searchButtonAction:(UIButton *)sender{
    
    
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    if (textField.tag == 1000) {
        
        UITextView *textView = (UITextView *)[self.searchScrollview viewWithTag:10000];
        textView.hidden = !textView.hidden;
    
    }


    return NO;
}
#pragma mark-----布局
- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    WeakSelf(self);
    [self.searchScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(weakself.view);
        make.top.mas_equalTo(SAFEAREATOP_HEIGHT);
        make.height.mas_equalTo(KSCREEN_HEIGHT-SAFEAREATOP_HEIGHT);
        
    }];
    
}
#pragma mark---------懒加载
- (UIScrollView *)searchScrollview{
    
    if (_searchScrollview == nil) {
        
        _searchScrollview = [[UIScrollView alloc]init];
        _searchScrollview.backgroundColor = [UIColor chains_colorWithHexString:kBackgroundColor alpha:1.0f];
        _searchScrollview.showsVerticalScrollIndicator = NO;
        _searchScrollview.pagingEnabled = YES;
        
    }
    
    return _searchScrollview;
}

@end
