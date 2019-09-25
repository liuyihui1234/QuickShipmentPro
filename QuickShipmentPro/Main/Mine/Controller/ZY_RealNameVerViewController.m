//
//  ZY_RealNameVerViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/8/13.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_RealNameVerViewController.h"
#import <Speech/Speech.h>
#import "ZYClipViewController.h"

@interface ZY_RealNameVerViewController ()<SFSpeechRecognizerDelegate,ClipViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic,strong)SFSpeechRecognizer *recognizer;
@property(nonatomic,strong)SFSpeechAudioBufferRecognitionRequest * recognitionRequest;
@property(nonatomic,strong)SFSpeechRecognitionTask * recognitionTask ;
@property (nonatomic,strong)AVAudioEngine * audioEngine;
@property(nonatomic,strong)UIImage *clipImage;
@property(assign,nonatomic)NSInteger buttonTag;

@property(nonatomic,strong)UIImage *cardFrontImage;
@property(nonatomic,strong)UIImage *cardBackImage;
@end

@implementation ZY_RealNameVerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"实名认证";
    [self drawMainUI];
    [self createToolBarView];
}
#pragma mark---验证码接口
- (void)requestVerificationCode{
    
    UITextField *phoneTextfield = (UITextField *)[self.view viewWithTag:200];
    NSString *phoneNum = [NSString stringWithFormat:@"%@",phoneTextfield.text];
    if (phoneNum.length == 0) {
        
        [self showToastMessage:@"手机号不能为空"];
    }
    else if ([ZYTools isMobileNumber:phoneNum] == NO){
        
        [self showToastMessage:@"请输入正确的手机号"];
    }
    else{
        [self showHudWithString:@"发送中..."];
        WeakSelf(self);
        NSDictionary *params = @{@"telephone":phoneNum};
        [[ZYNetworkHelper shareHttpManager] requsetWithUrl:[ApiConfig zy_SendSMSCode_URL] withParams:params withCacheType:ZYClientRequestCacheDataIgnore withRequestType:ZYNetworkTypePost withResult:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
            [weakself hidHud];
            if (responseObject) {
                
                NSSLog(@"-======%@",responseObject);
                ZY_Network_Model *network_Model = [ZY_Network_Model mj_objectWithKeyValues:responseObject];
                [weakself showToastMessage:network_Model.msg];
                if (network_Model.code == 1) {
                    UIButton *countdownButton = (UIButton *)[weakself.view viewWithTag:3000];
                    [countdownButton startWithSeconds:60];
                }
            }
        }];
    }
}
#pragma mark-----请求实名认证数据
- (void)requestRealNameAuthenticationDatas{
    WeakSelf(self);
    
    UITextField *phoneTextfield = (UITextField *)[self.view viewWithTag:200];
    UITextField *smsTextfield = (UITextField *)[self.view viewWithTag:201];
    
    UITextField *nameTextfield = (UITextField *)[self.view viewWithTag:400];
    UITextField *idCardTextfield = (UITextField *)[self.view viewWithTag:401];
    
    NSString *phoneNum = [NSString stringWithFormat:@"%@",phoneTextfield.text];
    NSString *smsCodeStr = [NSString stringWithFormat:@"%@",smsTextfield.text];
    NSString *nameStr = [NSString stringWithFormat:@"%@",nameTextfield.text];
    NSString *idCard = [NSString stringWithFormat:@"%@",idCardTextfield.text];
    
    if (phoneNum.length == 0) {

        [self showToastMessage:@"手机号不能为空"];
    }
    else if ([ZYTools isMobileNumber:phoneNum] == NO){

        [self showToastMessage:@"请输入正确的手机号"];
    }
    else if (smsCodeStr.length == 0){

        [self showToastMessage:@"请输入验证码"];
    }
    else if (nameStr.length == 0){

        [self showToastMessage:@"请输入真实姓名"];
    }
    else if (idCard.length == 0){

        [self showToastMessage:@"请输入身份证号"];
    }

   else if (!self.cardFrontImage) {

       [self showToastMessage:@"请上传身份证正面照"];

    }
   else if (!self.cardBackImage) {


       [self showToastMessage:@"请上传身份证背面照"];

   }
    else{

        NSData *frontSata = UIImageJPEGRepresentation(self.cardFrontImage,0.2f);
        NSString *frontEncodedImageStr = [frontSata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

        NSString *frontImage = [NSString stringWithFormat:@"%@",frontEncodedImageStr];


        NSData *backSata = UIImageJPEGRepresentation(self.cardBackImage,0.2f);
        NSString *backEncodedImageStr = [backSata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

        NSString *backImage = [NSString stringWithFormat:@"%@",backEncodedImageStr];

        NSDictionary *params = @{@"name":nameStr,@"identitynum":idCard,@"portraitpath":@"",@"smsCode":smsCodeStr,@"identityfontpath":frontImage,@"identitybackpath":backImage};

        [[ZYNetworkHelper shareHttpManager] requsetWithUrl:[ApiConfig zy_UpdateUserIdentity_URL] withParams:params withCacheType:ZYClientRequestCacheDataIgnore withRequestType:ZYNetworkTypePost withResult:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        [weakself hidHud];
        if (responseObject) {
            ZY_Network_Model *network_Model = [ZY_Network_Model mj_objectWithKeyValues:responseObject];
            [weakself showToastMessage:network_Model.msg];
            if (network_Model.code == 1) {

            }
            else{


            }
        }
    }];


    }
}
#pragma mark-----创建主模块
- (void)drawMainUI{
    
    WeakSelf(self);
    NSArray *firstArray = @[@[@"手机号：",@"请填写手机号"],@[@"验证码：",@"请输入验证码"]];
    __block UIView *firstBGView;
    [firstArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        firstBGView = [[UIView alloc]init];
        firstBGView.backgroundColor = [UIColor whiteColor];
        [weakself.view addSubview:firstBGView];
        [firstBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(weakself.view);
            make.top.mas_equalTo(SAFEAREATOP_HEIGHT+FitSize(15.0f) + idx*FitSize(46.0f));
            make.height.mas_equalTo(FitSize(45.0f));
        }];
        
        UILabel *leftTitleLabel = [[UILabel alloc]init];
        leftTitleLabel.font = ZYFontSize(13.0f);
        leftTitleLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        leftTitleLabel.text = [NSString stringWithFormat:@"%@",obj[0]];
        [firstBGView addSubview:leftTitleLabel];
        
        UITextField *cusTextField = [[UITextField alloc]init];
        cusTextField.font = ZYFontSize(14.0f);
        cusTextField.textColor = [UIColor blackColor];
        cusTextField.placeholder = [NSString stringWithFormat:@"%@",obj[1]];
        cusTextField.tag = idx + 200;
        
        cusTextField.keyboardType = UIKeyboardTypeNumberPad;
        [firstBGView addSubview:cusTextField];
        
        if (idx == 1) {
            cusTextField.rightViewMode = UITextFieldViewModeAlways;
            
            UIView *rightBGView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, FitSize(100.0f), FitSize(60.0f))];
            rightBGView.backgroundColor = [UIColor clearColor];
            cusTextField.rightView = rightBGView;
            
            UIView *lineHView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, FitSize(18.0f),FitSize(1.0f), FitSize(24.0f))];
            lineHView.backgroundColor = [UIColor chains_colorWithHexString:kLineColor alpha:1.0f];
            [rightBGView addSubview:lineHView];
            
            UIButton *countdownButton = [[UIButton alloc] initWithFrame:CGRectMake(FitSize(1.0f),0.0f,FitSize(99.0f), FitSize(60.0f))];
            countdownButton.titleLabel.font = ZYFontSize(13.0f);
            [countdownButton addTarget:self action:@selector(sendmyMessage:) forControlEvents:UIControlEventTouchUpInside];
            [countdownButton setTitleColor:[UIColor chains_colorWithHexString:kGrayColor alpha:1.0f] forState:UIControlStateNormal];
            [countdownButton setTitle:kSendVerifyCode forState:UIControlStateNormal];
            countdownButton.tag = 3000;
            [rightBGView addSubview:countdownButton];
        }
        [leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FitSize(12.0f));
            make.top.height.equalTo(firstBGView);
            make.width.mas_equalTo(FitSize(88.0f));
        }];
        [cusTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(leftTitleLabel.mas_right);
            make.top.height.equalTo(firstBGView);
            make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(128.0f));
            
        }];
        
    }];
    NSArray *secondArray = @[@[@"真实姓名：",@"请输入真实姓名"],@[@"身份证号：",@"请输入身份证号"]];
    __block UIView *secondBGView;
    [secondArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        secondBGView = [[UIView alloc]init];
        secondBGView.backgroundColor = [UIColor whiteColor];
        
        [weakself.view addSubview:secondBGView];
        [secondBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(firstBGView);
            make.top.equalTo(firstBGView.mas_bottom).offset(FitSize(15.0f) + idx*FitSize(46.0f));
        }];
        
        UILabel *leftTitleLabel = [[UILabel alloc]init];
        leftTitleLabel.font = ZYFontSize(13.0f);
        leftTitleLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        leftTitleLabel.text = [NSString stringWithFormat:@"%@",obj[0]];
        [secondBGView addSubview:leftTitleLabel];
        
        UITextField *cusTextField = [[UITextField alloc]init];
        cusTextField.font = ZYFontSize(14.0f);
        cusTextField.textColor = [UIColor blackColor];
        cusTextField.placeholder = [NSString stringWithFormat:@"%@",obj[1]];
        cusTextField.tag = idx + 400;
        
        [secondBGView addSubview:cusTextField];
        
        [leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FitSize(12.0f));
            make.top.height.equalTo(secondBGView);
            make.width.mas_equalTo(FitSize(88.0f));
        }];
        [cusTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(leftTitleLabel.mas_right);
            make.top.height.equalTo(secondBGView);
            make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(128.0f));
        }];
    }];
    
    UIView *thirdBGView = [[UIView alloc]init];
    thirdBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:thirdBGView];
    [thirdBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakself.view);
        make.top.equalTo(secondBGView.mas_bottom).offset(FitSize(15.0f));
        make.height.mas_equalTo(FitSize(268.0f));
    }];
    //thirdBGView控件
    UILabel *noticeLabel = [[UILabel alloc]init];
    noticeLabel.font = ZYFontSize(13.0f);
    noticeLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    noticeLabel.text = @"请拍摄并上传身份证";
    [thirdBGView addSubview:noticeLabel];
    
    UIButton *frontCardIDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [frontCardIDButton setImage:[UIImage imageNamed:@"frontCardimg"] forState:UIControlStateNormal];
    [frontCardIDButton addTarget:self action:@selector(cardIDAction:) forControlEvents:UIControlEventTouchUpInside];
    frontCardIDButton.tag = 1000;
    [thirdBGView addSubview:frontCardIDButton];
    
    UIButton *backCardIDButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backCardIDButton setImage:[UIImage imageNamed:@"backCarIDimg"] forState:UIControlStateNormal];
    [backCardIDButton addTarget:self action:@selector(cardIDAction:) forControlEvents:UIControlEventTouchUpInside];
    backCardIDButton.tag = 2000;
    [thirdBGView addSubview:backCardIDButton];
    
    UILabel *frontLabel = [[UILabel alloc]init];
    frontLabel.font = ZYFontSize(12.0f);
    frontLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
    frontLabel.text = @"点击上传带头像的一面";
    frontLabel.textAlignment = NSTextAlignmentCenter;
    [thirdBGView addSubview:frontLabel];
    
    UILabel *backIDLabel = [[UILabel alloc]init];
    backIDLabel.font = ZYFontSize(12.0f);
    backIDLabel.textColor = [UIColor chains_colorWithHexString:kDarkGrayColor alpha:1.0f];
    backIDLabel.text = @"点击上传带国徽的一面";
    backIDLabel.textAlignment = NSTextAlignmentCenter;
    [thirdBGView addSubview:backIDLabel];
    
    UILabel *showMesLabel = [[UILabel alloc]init];
    showMesLabel.font = ZYFontSize(13.0f);
    showMesLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    showMesLabel.numberOfLines = 0;
    showMesLabel.text = @"照片信息清晰可见，信息完整无缺失，身份证照片真实严禁经过PS处理";
    [thirdBGView addSubview:showMesLabel];
    
    CGFloat cusWidth = (KSCREEN_WIDTH-FitSize(36.0f))/2;
    [noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(FitSize(12.0f));
        make.top.equalTo(thirdBGView);
        make.height.mas_equalTo(FitSize(40.0f));
        make.width.mas_equalTo(KSCREEN_WIDTH-FitSize(24.0f));
    }];
    [frontCardIDButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noticeLabel);
        make.top.equalTo(noticeLabel.mas_bottom).offset(FitSize(9.0f));
        make.height.mas_equalTo(FitSize(120.0f));
        make.width.mas_equalTo(cusWidth);
    }];
    [backCardIDButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-FitSize(12.0f));
        make.top.height.width.equalTo(frontCardIDButton);
        
    }];
    [frontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(frontCardIDButton);
        make.top.mas_equalTo(frontCardIDButton.mas_bottom);
        make.height.mas_equalTo(FitSize(40.0f));
    }];
    [backIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(backCardIDButton);
        make.top.height.width.equalTo(frontLabel);
    }];
    [showMesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(noticeLabel);
        make.top.equalTo(frontLabel.mas_bottom).offset(FitSize(6.0f));
        make.height.mas_equalTo(FitSize(40.0f));
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
- (void)cardIDAction:(UIButton *)sender{
   
    self.buttonTag = sender.tag;
    [self openCameraOrPhotoLibrary];
}

#pragma mark----保存按钮事件
- (void)customButtonAction:(UIButton *)sender{
    
    
    [self requestRealNameAuthenticationDatas];
    
}
#pragma mark ----发送验证码----
- (void)sendmyMessage:(UIButton *)sender{
    
    [self requestVerificationCode];
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

- (UIImage *)fixOrientation:(UIImage *)originalImage{
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

    UIButton *uploadButton = (UIButton *)[self.view viewWithTag:self.buttonTag];
    [uploadButton setImage:clipedImage forState:UIControlStateNormal];
    if (self.buttonTag == 1000) {
     //  [self recognizeWithTesseract:clipedImage];
        self.cardFrontImage = clipedImage;
    }
    else{
        
        self.cardBackImage = clipedImage;
    }
     [self dismissViewControllerAnimated:YES completion:nil];
}
//recognize image with tesseract
//-(void)recognizeWithTesseract:(UIImage *)image{
//    WeakSelf(self);
//    [self showHudWithString:@"正在识别分析图片中..."];
//    [[RecogizeCardManager recognizeCardManager] tesseractRecognizeImage:image compleate:^(NSString * _Nonnull text) {
//        [weakself hidHud];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (text != nil) {
//
//                UITextField *cusTextField = (UITextField *)[weakself.view viewWithTag:401];
//                cusTextField.text = [NSString stringWithFormat:@"%@",text];
//
//            }else {
//                [weakself showToastMessage:@"照片识别失败，请选择清晰的照片重试！"];
//            }
//        });
//    }];
//}


@end
