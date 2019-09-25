//
//  ZY_HomeUserInfoViewController.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/7/23.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZY_HomeUserInfoViewController.h"
#import "ZY_HomeUserInfoModel.h"
#import "ZY_ChangeMessageViewController.h"//修改信息
@interface ZY_HomeUserInfoViewController ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) CLLocation *location;

@end

@implementation ZY_HomeUserInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人信息";
    [self drawNavUI];
    [self drawUserMessageUI];
}
#pragma mark-----自定义返回按钮
- (void)drawNavUI{
    
    UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backWhiteImg"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = itemleft;
    
}
- (void)backButtonAction:(UIBarButtonItem *)tab{
    
    if (self.changeUserInfoClickBlock) {
        self.changeUserInfoClickBlock();
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark----修改个人信息接口
- (void)changePersonalInformationDatasWithNickName:(NSString *)nickName phone:(NSString *)phone iconUrl:(NSString *)iconUrl Tag:(NSInteger)tag{
    
    WeakSelf(self);
    [self showHudWithString:@"修改中..."];
    NSString *userID = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YUSERID]];
    NSDictionary *params = @{@"id":userID,@"Name":nickName,@"Mobile":phone,@"portraitpath":iconUrl};
    [[ZYNetworkHelper shareHttpManager] requsetWithUrl:[ApiConfig zy_ChangePersonalInformation_URL] withParams:params withCacheType:ZYClientRequestCacheDataIgnore withRequestType:ZYNetworkTypePost withResult:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        [weakself hidHud];
        if (responseObject) {
            
            ZY_Network_Model *network_Model = [ZY_Network_Model mj_objectWithKeyValues:responseObject];
            if (network_Model.code == 1) {
                
                ZY_HomeUserInfoModel *model = [ZY_HomeUserInfoModel mj_objectWithKeyValues:network_Model.data];
                if(tag == 1000){
                    UIImageView *selectImage = (UIImageView *)[weakself.view viewWithTag:10000];
                    [selectImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.portraitpath]]];
                    [ZYTools saveToken:model.portraitpath withKey:FZ_YPROTRAITPATHID];
                }
                else if (tag == 1001) {
                    UILabel *customLabel = (UILabel *)[weakself.view viewWithTag:301];
                    customLabel.text = nickName;
                    [ZYTools saveToken:model.name withKey:FZ_YUSERNAMEID];
                }
                else{
                    UILabel *customLabel = (UILabel *)[weakself.view viewWithTag:302];
                    customLabel.text = phone;
                    [ZYTools saveToken:model.mobile withKey:FZ_YUSERMOBILEID];
                }
                [weakself showToastMessage:network_Model.msg];
            }
            else{
                
                [weakself showToastMessage:network_Model.msg];
            }
        }
    }];
}


#pragma mark----创建模块
- (void)drawUserMessageUI{
    
    WeakSelf(self);
    
    NSString *iconUrl = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YPROTRAITPATHID]];
    NSString *nickName = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YUSERNAMEID]];
    NSString *telPhone = [NSString stringWithFormat:@"%@",[ZYTools getTokenWithKey:FZ_YUSERMOBILEID]];
    
    NSArray *menuArray = @[@[@"头像",iconUrl],@[@"名字",nickName],@[@"手机号",telPhone]];
    
    __block UIView *bgView;
    [menuArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        bgView = [[UIView alloc]init];
        bgView.backgroundColor = [UIColor chains_colorWithHexString:kWhiteColor alpha:1.0f];
        bgView.tag = idx + 1000;
        [weakself.view addSubview:bgView];
        
        if (idx == 0) {
            
            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.width.equalTo(weakself.view);
                make.height.mas_equalTo(FitSize(54.0f));
                make.top.mas_equalTo(SAFEAREATOP_HEIGHT+idx*FitSize(55.0f));
            }];
        }
        else{
            
            [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.width.equalTo(weakself.view);
                make.height.mas_equalTo(FitSize(44.0f));
                make.top.mas_equalTo(SAFEAREATOP_HEIGHT+FitSize(10.0f)+idx*FitSize(45.0f));
            }];
            
        }
        
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.font = ZYFontSize(13.0f);
        titleLabel.textColor = [UIColor chains_colorWithHexString:kDarkColor alpha:1.0f];
        titleLabel.text = [NSString stringWithFormat:@"%@",obj[0]];
        [bgView addSubview:titleLabel];
        
        UIImageView *arrowImage = [[UIImageView alloc]init];
        arrowImage.contentMode = UIViewContentModeRight;
        arrowImage.image = [UIImage imageNamed:@"mineArrow"];
        [bgView addSubview:arrowImage];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(FitSize(20.0f));
            make.top.height.equalTo(bgView);
            make.width.mas_equalTo(FitSize(80.0f));
            
        }];
        [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-FitSize(14.0f));
            make.top.height.equalTo(bgView);
            make.width.equalTo(@(FitSize(20.0f)));
        }];
        if (idx == 0) {
            
            UIImageView *iconImageView = [[UIImageView alloc]init];
            iconImageView.layer.cornerRadius = FitSize(22.0f);
            iconImageView.clipsToBounds = YES;
            [iconImageView sd_setImageWithURL:[NSURL URLWithString:obj[1]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            iconImageView.tag = 10000;
            [bgView addSubview:iconImageView];
            [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(arrowImage.mas_left);
                make.centerY.equalTo(bgView);
                make.height.width.mas_equalTo(FitSize(44.0f));
            }];
        }
        else {
            
            UILabel *rightLabel = [[UILabel alloc]init];
            rightLabel.font = ZYFontSize(13.0f);
            rightLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
            rightLabel.textAlignment = NSTextAlignmentRight;
            rightLabel.text = [NSString stringWithFormat:@"%@",obj[1]];
            rightLabel.tag = idx+300;
            [bgView addSubview:rightLabel];
            
            [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(arrowImage.mas_left);
                make.top.height.equalTo(bgView);
                make.width.lessThanOrEqualTo(@(FitSize(200.0f)));
                
            }];
        }
        //单击的手势
        UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        tapRecognize.numberOfTapsRequired = 1;
        [tapRecognize setEnabled :YES];
        [tapRecognize delaysTouchesBegan];
        [bgView addGestureRecognizer:tapRecognize];
    }];
    
}
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}
#pragma mark - UIImagePickerController
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}
// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.navigationBar.translucent = YES;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    imagePickerVc.photoWidth = FitSize(190.0f);
    imagePickerVc.allowCrop = YES;
    //imagePickerVc.needCircleCrop = YES;//圆形切框
    imagePickerVc.circleCropRadius = FitSize(190.0f);
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    [imagePickerVc.navigationBar navBarBackGroundColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] image:nil isOpaque:YES];//颜色
    imagePickerVc.oKButtonTitleColorDisabled = [UIColor whiteColor];
    imagePickerVc.oKButtonTitleColorNormal = [UIColor whiteColor];
    imagePickerVc.navigationBar.translucent = NO;
    imagePickerVc.iconThemeColor = [UIColor redColor];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    
    
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    // 3. Set allow picking video & photo & originalPhoto or not
    imagePickerVc.allowPickingImage = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    
    // 设置竖屏下的裁剪尺寸
    NSInteger left = FitSize(15.0f);
    NSInteger widthHeight = self.view.frame.size.width - 2 * left;
    NSInteger top = (self.view.frame.size.height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = YES;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [tzImagePickerVc showProgressHUD];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    // save photo and get asset / 保存图片，获取到asset
    [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
        [tzImagePickerVc hideProgressHUD];
        if (error) {
            NSSLog(@"图片保存失败 %@",error);
        } else {
            TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
            
            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                [self refreshCollectionViewWithAddedAsset:assetModel.asset image:cropImage];
                
                
            }];
            imagePicker.allowPickingImage = YES;
            imagePicker.circleCropRadius = FitSize(190.0f);
            [imagePicker.navigationBar navBarBackGroundColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] image:nil isOpaque:YES];//颜色
            imagePicker.oKButtonTitleColorDisabled = [UIColor whiteColor];
            imagePicker.oKButtonTitleColorNormal = [UIColor whiteColor];
            imagePicker.navigationBar.translucent = NO;
            imagePicker.iconThemeColor = [UIColor redColor];
            imagePicker.showPhotoCannotSelectLayer = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        
    }];
}
- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    
    UIImageView *selectImage = (UIImageView *)[self.view viewWithTag:10000];
    selectImage.image = image;
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = asset;
        NSSLog(@"location:%@",phAsset.location);
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    if (photos.count > 0) {
        
        UIImage *image = photos[0];
        
        
        NSData *data = UIImageJPEGRepresentation(image,1.0);
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self changePersonalInformationDatasWithNickName:@"" phone:@"" iconUrl:encodedImageStr Tag:1000];
        
    }
}
#pragma mark-----手势事件
- (void)handleTap:(UITapGestureRecognizer *)tap{
    
    UIView *tapView = [tap view];
    
    WeakSelf(self);
    if(tapView.tag == 1000){
        //头像更换
        NSString *takePhotoTitle = @"拍照";
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself takePhoto];
        }];
        [alertVc addAction:takePhotoAction];
        UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakself pushTZImagePickerController];
        }];
        [alertVc addAction:imagePickerAction];
        UIAlertAction *saveIocnPickerAction = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //保存头像
            UIImageView *imageView = (UIImageView *)[weakself.view viewWithTag:10000];
            [weakself loadImageFinished:imageView.image];
            
        }];
        [alertVc addAction:saveIocnPickerAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVc addAction:cancelAction];
        [self presentViewController:alertVc animated:YES completion:nil];
    }
    else{
        
        ZY_ChangeMessageViewController *messageVC = [[ZY_ChangeMessageViewController alloc]init];
        UILabel *cusLabel = (UILabel *)[tapView viewWithTag:tapView.tag-1000+300];
        NSString *selectedTitle;
        if (tapView.tag == 1001){
            //名字
            selectedTitle = @"修改名字";
            
        }
        else{
            //电话
            selectedTitle = @"修改手机号";
        }
        
        messageVC.titleString = selectedTitle;
        messageVC.textString = cusLabel.text;
        messageVC.changeUserInfoClickBlock = ^(NSString * _Nonnull changeMes) {
            
            if (tapView.tag == 1001) {
                
                [self changePersonalInformationDatasWithNickName:changeMes phone:@"" iconUrl:@"" Tag:tapView.tag];
            }
            else{
                
                [self changePersonalInformationDatasWithNickName:@"" phone:changeMes iconUrl:@"" Tag:tapView.tag];
            }
        };
        
        [self.navigationController pushViewController:messageVC animated:YES];
        
    }
}
#pragma mark----下载图片
- (void)loadImageFinished:(UIImage *)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *msg;
    
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
        
    }
    [self showToastMessage:msg];
}
@end
