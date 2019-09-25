//
//  ZY_AddNewAddressViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/14.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_AddNewAddressViewController.h"
#import "ZYAddTitleAddressView.h"
#import <Speech/Speech.h>
#import "ZYClipViewController.h"

@interface ZY_AddNewAddressViewController ()<ZYAddTitleAddressViewDelegate,SFSpeechRecognizerDelegate,ClipViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)ZYAddTitleAddressView *addTitleAddressView;
@property (nonatomic,strong)SFSpeechRecognizer *recognizer;
@property(nonatomic,strong)SFSpeechAudioBufferRecognitionRequest * recognitionRequest;
@property(nonatomic,strong)SFSpeechRecognitionTask * recognitionTask ;
@property (nonatomic,strong)AVAudioEngine * audioEngine;
@property(nonatomic,strong)UIImage *clipImage;
@end

@implementation ZY_AddNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *titleString = self.selectedType == 1000 ? @"寄件人地址填写" : @"收件人地址填写";
    self.navigationItem.title = titleString;
    [self createAddNewAddressUI];
    [self createToolBarView];
    [self createAddressSelectedUI];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-CN"];
    if (@available(iOS 10.0, *)) {
        _recognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
    } else {
        // Fallback on earlier versions
    }
    
    //把语音识别的代理设置为 self
    _recognizer.delegate = self;
    
    //发送语音认证请求(首先要判断设备是否支持语音识别功能)
    [self requestJurisdiction];
    self.audioEngine = [[AVAudioEngine alloc]init];
    self.clipImage = [UIImage imageNamed:@"image_sample"];
}
#pragma mark---语音模块
- (void)requestJurisdiction{
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        
        BOOL isButtonEnable = NO;
    //检查验证的状态。如果被授权了，让microphone按钮有效。如果没有，打印错误信息然后让microphone按钮失效。
        switch (status) {
            case SFSpeechRecognizerAuthorizationStatusAuthorized:
            {
                isButtonEnable = YES;
                NSLog(@"用户授权语音识别");
            }
                break;
                
            case SFSpeechRecognizerAuthorizationStatusDenied:
            {
                isButtonEnable = NO;
                NSLog(@"用户拒绝授权语音识别");
            }
                break;
            case SFSpeechRecognizerAuthorizationStatusRestricted:
            {
                isButtonEnable = NO;
                NSLog(@"设备不支持语音识别功能");
            }
                break;
            case SFSpeechRecognizerAuthorizationStatusNotDetermined:
            {
                isButtonEnable = NO;
                NSLog(@"结果未知 用户尚未进行选择");
            }
                break;
        }
    }];
}
#pragma mark----创建主模块
- (void)createAddNewAddressUI{
    WeakSelf(self);
    UIView *firstBGView = [[UIView alloc]init];
    firstBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstBGView];
    
    UIView *secondBGView = [[UIView alloc]init];
    secondBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondBGView];
    [firstBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(weakself.view);
        make.top.mas_equalTo(SAFEAREATOP_HEIGHT);
        make.height.mas_equalTo(FitSize(210.0f));
    }];
    [secondBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.equalTo(weakself.view);
        make.top.equalTo(firstBGView.mas_bottom).offset(FitSize(12.0f));
        make.height.mas_equalTo(FitSize(140.0f));
    }];
    //firstBGView
    UITextField *nameTextField = [[UITextField alloc]init];
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.font = ZYFontSize(13.0f);
    nameTextField.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    nameTextField.placeholder = @"姓名";
    [nameTextField setValue:[UIColor chains_colorWithHexString:kGrayColor alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [firstBGView addSubview:nameTextField];
    
    UIView *verticalView = [[UIView alloc]init];
    verticalView.backgroundColor = [UIColor chains_colorWithHexString:kLightDarkColor alpha:1.0f];
    [firstBGView addSubview:verticalView];
    
    UITextField *phoneTextfiled = [[UITextField alloc]init];
    phoneTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextfiled.font = ZYFontSize(13.0f);
    phoneTextfiled.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    phoneTextfiled.placeholder = @"电话";
    [phoneTextfiled setValue:[UIColor chains_colorWithHexString:kGrayColor alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    phoneTextfiled.rightViewMode = UITextFieldViewModeAlways;
    UIView *rightCusView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, FitSize(90.0f), FitSize(24.0f))];
    phoneTextfiled.rightView = rightCusView;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = ZYFontSize(13.0f);
    titleLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    titleLabel.text = @"-分机号";
    [rightCusView addSubview:titleLabel];
    
    UIButton *editBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:[UIImage imageNamed:@"lianxiren"] forState:UIControlStateNormal];
    [rightCusView addSubview:editBtn];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.height.equalTo(rightCusView);
        make.width.mas_equalTo(FitSize(60.0f));
        
    }];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right);
        make.top.height.equalTo(rightCusView);
        make.width.mas_equalTo(FitSize(29.0f));
    }];
    [firstBGView addSubview:phoneTextfiled];
    
    UIView *crossLineView = [[UIView alloc]init];
    crossLineView.backgroundColor = [UIColor chains_colorWithHexString:kLightDarkColor alpha:1.0f];
    [firstBGView addSubview:crossLineView];

    CGFloat spaceX = FitSize(12.0f);
    [nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(spaceX);
        make.top.mas_equalTo(FitSize(12.0f));
        make.height.mas_equalTo(FitSize(24.0f));
        make.width.mas_equalTo(FitSize(97.0f));
    }];
    
    [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameTextField.mas_right);
        make.top.height.equalTo(nameTextField);
        make.width.mas_equalTo(FitSize(1.0f));
    }];

    [phoneTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalView.mas_right).offset(FitSize(17.0f));
        make.top.height.equalTo(nameTextField);
        make.right.mas_equalTo(-spaceX);
    }];
    [crossLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameTextField);
        make.top.equalTo(verticalView.mas_bottom).offset(FitSize(5.0f));
        make.right.equalTo(phoneTextfiled);
        make.height.mas_equalTo(FitSize(1.0f));
    
    }];
    NSArray *addressArray = @[@"省市区",@"详细地址（精确到门牌号）",@"公司名称（选填）"];
    [addressArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        UITextField *addressTextfiled = [[UITextField alloc]init];
        addressTextfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        addressTextfiled.font = ZYFontSize(14.0f);
        addressTextfiled.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        addressTextfiled.placeholder = obj;
        addressTextfiled.tag = idx + 500;
        [addressTextfiled setValue:[UIColor chains_colorWithHexString:kGrayColor alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
        if (idx == 0) {
            addressTextfiled.rightViewMode = UITextFieldViewModeAlways;
            
            UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [locationBtn setImage:[UIImage imageNamed:@"dingweidizhi"] forState:UIControlStateNormal];
            locationBtn.frame = CGRectMake(0.0, 0.0f,FitSize(27.0f), FitSize(40.0f));
            [locationBtn addTarget:self action:@selector(locationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            addressTextfiled.rightView = locationBtn;
        }
        [firstBGView addSubview:addressTextfiled];
        
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor chains_colorWithHexString:kLightDarkColor alpha:1.0f];
        [firstBGView addSubview:bottomView];
        
        [addressTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(crossLineView);
            make.top.equalTo(crossLineView.mas_bottom).offset(idx*FitSize(41.0f));
            make.height.mas_equalTo(FitSize(40.0f));
        }];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(addressTextfiled);
            make.top.equalTo(addressTextfiled.mas_bottom);
            make.height.mas_equalTo(FitSize(1.0f));
        }];
    }];
    
    ZYCustomButton *saveAddressButton = [ZYCustomButton buttonWithType:UIButtonTypeCustom];
    [saveAddressButton setTitleColor:[UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f] forState:UIControlStateNormal];
    saveAddressButton.titleLabel.font = ZYFontSize(13.0f);
    saveAddressButton.zy_spacing = FitSize(3.0f);
    [saveAddressButton setImage:[UIImage imageNamed:@"paynoseleled"] forState:UIControlStateNormal];
    [saveAddressButton setImage:[UIImage imageNamed:@"payseleled"] forState:UIControlStateSelected];
    [saveAddressButton setTitle:@"保存到地址簿" forState:UIControlStateNormal];
    [saveAddressButton addTarget:self action:@selector(saveAddressButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    saveAddressButton.zy_buttonType = ZYCustomButtonImageLeft;
    //水平左对齐
    saveAddressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [firstBGView addSubview:saveAddressButton];

    UIButton *clearMesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearMesButton setTitle:@"清空当前信息" forState:UIControlStateNormal];
    [clearMesButton setTitleColor:[UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f] forState:UIControlStateNormal];
    clearMesButton.titleLabel.font = ZYFontSize(13.0f);
    [clearMesButton addTarget:self action:@selector(clearMesButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    clearMesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [firstBGView addSubview:clearMesButton];
    
    [saveAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(firstBGView);
        make.left.equalTo(crossLineView);
        make.width.mas_equalTo(FitSize(120.0f));
        make.height.mas_equalTo(FitSize(45.0f));
    }];
    [clearMesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(crossLineView);
        make.top.height.equalTo(saveAddressButton);
        make.width.mas_equalTo(FitSize(110.0f));
        
    }];
    //secondBGView
    UIView *boxView = [[UIView alloc]init];
    boxView.backgroundColor = [UIColor clearColor];
    boxView.layer.borderWidth = FitSize(1.0f);
    boxView.layer.borderColor = [UIColor chains_colorWithHexString:kLightDarkColor alpha:1.0f].CGColor;
    [secondBGView addSubview:boxView];
    [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(secondBGView);
        make.height.mas_equalTo(FitSize(104.0f));
        make.width.equalTo(crossLineView);
    }];

    CGFloat spaceW = FitSize(11.0f);
    ZYTextView *cusTextView = [[ZYTextView alloc]init];
    [cusTextView setPlaceHolderX:FitSize(23.0f)];
    cusTextView.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
    cusTextView.tag = 10000;
    cusTextView.font = ZYFontSize(12.0f);
    cusTextView.textContainerInset = UIEdgeInsetsMake(spaceW,FitSize(15.0f), spaceW,spaceW);
    cusTextView.placeHolder = @"粘贴地址信息，自动拆分姓名、电话和地址";
    [boxView addSubview:cusTextView];

    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setImage:[UIImage imageNamed:@"xiangjiimg"] forState:UIControlStateNormal];
    [photoButton addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [boxView addSubview:photoButton];
    
    UIButton *voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceButton setImage:[UIImage imageNamed:@"yuyinweino"] forState:UIControlStateNormal];
    [voiceButton setImage:[UIImage imageNamed:@"yuyinimage"] forState:UIControlStateSelected];
    
    [voiceButton addTarget:self action:@selector(voiceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [boxView addSubview:voiceButton];
    
    [cusTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(boxView);
        make.height.mas_equalTo(FitSize(75.0f));
    }];
    
    [photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-FitSize(10.0f));
        make.left.mas_equalTo(FitSize(20.0f));
        make.height.mas_equalTo(FitSize(16.0f));
        make.width.mas_equalTo(FitSize(23.0f));
    
    }];
    [voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.height.width.equalTo(photoButton);
        make.left.equalTo(photoButton.mas_right).offset(FitSize(15.0f));
       
    }];
}
#pragma mark----创建底部模块
- (void)createToolBarView{
    
    WeakSelf(self);
    UIView *cusToolBar = [[UIView alloc]init];
    cusToolBar.backgroundColor = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
    [self.view addSubview:cusToolBar];
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.backgroundColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    [customButton setTitle:@"保存" forState:UIControlStateNormal];
    [customButton setTitleColor:[UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f] forState:UIControlStateNormal];
    customButton.titleLabel.font = ZYFontSize(19.0f);
    customButton.layer.cornerRadius = FitSize(24.0f);
    [customButton addTarget:self action:@selector(customButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cusToolBar addSubview:customButton];
    
    [cusToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.width.equalTo(weakself.view);
        make.height.equalTo(@(FitSize(70.0f)+SAFEAREABOTTOM_HEIGHT));
    }];
    [customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cusToolBar);
        make.top.mas_equalTo(FitSize(16.0f));
        make.width.mas_equalTo(FitSize(211.0f));
        make.height.mas_equalTo(FitSize(48.0f));
    }];
}
#pragma mark------添加地址选择
- (void)createAddressSelectedUI{
    self.addTitleAddressView = [[ZYAddTitleAddressView alloc]init];
    self.addTitleAddressView.title = @"选择地址";
    self.addTitleAddressView.userID = 7;
    self.addTitleAddressView.addressDelegate = self;
    self.addTitleAddressView.defaultHeight = FitSize(350.0f);
    self.addTitleAddressView.titleScrollViewH = FitSize(37.0f);
    [self.view addSubview:[self.addTitleAddressView initAddressView]];
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,FitSize(200.0f)) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tag = 0;
    self.addTitleAddressView.tableViewMarr = [[NSMutableArray alloc]init];
    self.addTitleAddressView.titleMarr = [[NSMutableArray alloc]init];
    [self.addTitleAddressView.tableViewMarr addObject:tableView];
    [self.addTitleAddressView.titleMarr addObject:@"请选择"];
    //1.添加标题滚动视图
    [self.addTitleAddressView setupTitleScrollView];
    //2.添加内容滚动视图
    [self.addTitleAddressView setupContentScrollView];
    [self.addTitleAddressView setupAllTitle:0];
}
#pragma mark------代理方法
- (void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID{
    
    UITextField *addressTextfiled = (UITextField *)[self.view viewWithTag:500];
    addressTextfiled.text = [NSString stringWithFormat:@"%@",titleAddress];
  //  NSLog( @"%@", [NSString stringWithFormat:@"打印的对应省市县的id=%@",titleID]);
}

#pragma mark  -- 打开相机或相册

/**
 *  打开相机或相册
 */
- (void)openCameraOrPhotoLibrary
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 打开相机 比较懒，暂时先这样获取访问权限
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [self openWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        // 打开相册
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            [self openWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
}

//
- (void)openWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType = sourceType;
    imagePickerVC.delegate = self;
    imagePickerVC.navigationBar.translucent = NO;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([navigationController isKindOfClass:[UIImagePickerController class]]) {
        
        //导航栏背景色
        [navigationController.navigationBar navBarBackGroundColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] image:nil isOpaque:YES];//颜色
        [navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
        
        [navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:ZYFontSize(17.0f),NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        // 导航栏左右按钮字体颜色
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
       
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    ZYClipViewController *clipVC = [[ZYClipViewController alloc] init];
    clipVC.delegate = self;
    clipVC.needClipImage = [self fixOrientation:info[UIImagePickerControllerOriginalImage]];
    [picker pushViewController:clipVC animated:YES];
}

- (UIImage *)fixOrientation:(UIImage *)originalImage
{
    if (originalImage.imageOrientation == UIImageOrientationUp) return originalImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (originalImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.width, originalImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, originalImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (originalImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, originalImage.size.width, originalImage.size.height,
                                             CGImageGetBitsPerComponent(originalImage.CGImage), 0,
                                             CGImageGetColorSpace(originalImage.CGImage),
                                             CGImageGetBitmapInfo(originalImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (originalImage.imageOrientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.height,originalImage.size.width), originalImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.width,originalImage.size.height), originalImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark  -- ClipViewControllerDelegate
- (void)didSuccessClipImage:(UIImage *)clipedImage{
    
//    self.clipedImageView.backgroundColor = [UIColor redColor];
//    self.clipedImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.clipedImageView.image = clipedImage;
    [self recognizeWithTesseract:clipedImage];
   
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//recognize image with tesseract
- (void)recognizeWithTesseract:(UIImage *)image{
  
    
    
    
    
}
#pragma mark-----定位地址按钮事件
- (void)locationBtnAction:(UIButton *)sender{
    
    [self.addTitleAddressView addAnimate];
}
#pragma mark------保存到地址簿
- (void)saveAddressButtonAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
}
#pragma mark------清空当前信息
- (void)clearMesButtonAction:(UIButton *)sender{
    
    
}
- (void)photoButtonAction:(UIButton *)sender{
    
    [self openCameraOrPhotoLibrary];
    
}
- (void)voiceButtonAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        
        if (self.recognitionTask) {
            [self.recognitionTask cancel];
            self.recognitionTask = nil;
        }
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        bool  audioBool = [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
        bool  audioBool1= [audioSession setMode:AVAudioSessionModeMeasurement error:nil];
        bool  audioBool2= [audioSession setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
        if (audioBool || audioBool1||  audioBool2) {
            NSLog(@"可以使用");
        }else{
            NSLog(@"这里说明有的功能不支持");
        }
        self.recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc]init];
        AVAudioInputNode *inputNode = self.audioEngine.inputNode;
        
        self.recognitionRequest.shouldReportPartialResults = true;
        ZYTextView *cusTextView = (ZYTextView *)[self.view viewWithTag:10000];
        
        //开始识别任务
        self.recognitionTask = [self.recognizer recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        
            bool isFinal = false;
            if (result) {
                cusTextView.text = [[result bestTranscription] formattedString];
                //语音转文本
                isFinal = [result isFinal];
            }
            if (error || isFinal) {
                [self.audioEngine stop];
                [inputNode removeTapOnBus:0];
                self.recognitionRequest = nil;
                self.recognitionTask = nil;
            }
        }];
        AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
        [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
            
            [self.recognitionRequest appendAudioPCMBuffer:buffer];
        }];
        [self.audioEngine prepare];
        bool audioEngineBool = [self.audioEngine startAndReturnError:nil];
        NSLog(@"%d",audioEngineBool);
        cusTextView.placeHolder = @"";
    }
    else{
        
        if ([self.audioEngine isRunning]) {
            [self.audioEngine stop];
            [self.recognitionRequest endAudio];
        }
    }
}
#pragma mark----保存按钮事件
- (void)customButtonAction:(UIButton *)sender{

    // [self recognizeWithTesseract:[UIImage imageNamed:@"eng"]];
}
//当语音识别操作可用性发生改变时会被调用
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
    if (available) {
        
    }else{
        
    }
}
- (void)dealloc {
    
    [self.recognitionTask cancel];
    
    self.recognitionTask = nil;
    
}
@end
