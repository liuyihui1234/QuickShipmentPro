//
//  ZYAddTitleAddressView.m
//  QuickShipmentPro
//
//  Created by 飞之翼 on 2019/9/2.
//  Copyright © 2019 飞之翼. All rights reserved.
//

#import "ZYAddTitleAddressView.h"
#import "ProvinceModel.h"
#import "CityModel.h"
#import "CountyModel.h"
#import "TownModel.h"
@interface ZYAddTitleAddressView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView *titleScrollView;
@property(nonatomic,strong)UIScrollView *contentScrollView;
@property(nonatomic,strong)UIButton *radioBtn;
@property(nonatomic,strong)NSMutableArray *titleBtns;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)NSMutableArray *titleIDMarr;
@property(nonatomic,assign)BOOL isInitalize;
@property(nonatomic,assign)BOOL isclick; //判断是滚动还是点击
@property(nonatomic,strong)NSMutableArray *provinceMarr;//省
@property(nonatomic,strong)NSMutableArray *cityMarr;//市
@property(nonatomic,strong)NSMutableArray *countyMarr;//县
@property(nonatomic,strong)NSMutableArray *townMarr;//乡
@property(nonatomic,strong)NSArray *resultArr;//本地数组
@end
@implementation ZYAddTitleAddressView

-(NSMutableArray *)titleBtns
{
    if (_titleBtns == nil) {
        _titleBtns = [[NSMutableArray alloc]init];
    }
    return _titleBtns;
}
-(NSMutableArray *)titleIDMarr
{
    if (_titleIDMarr == nil) {
        _titleIDMarr = [[NSMutableArray alloc]init];
    }
    return _titleIDMarr;
}
-(NSMutableArray *)provinceMarr
{
    if (_provinceMarr == nil) {
        _provinceMarr = [[NSMutableArray alloc]init];
    }
    return _provinceMarr;
}
-(NSMutableArray *)cityMarr
{
    if (_cityMarr == nil) {
        _cityMarr = [[NSMutableArray alloc]init];
    }
    return _cityMarr;
}
-(NSMutableArray *)countyMarr
{
    if (_countyMarr == nil) {
        _countyMarr = [[NSMutableArray alloc]init];
    }
    return _countyMarr;
}
-(NSMutableArray *)townMarr
{
    if (_townMarr == nil) {
        _townMarr = [[NSMutableArray alloc]init];
    }
    return _townMarr;
}
-(UIView *)initAddressView{
    //初始化本地数据（如果是网络请求请注释掉-----
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:imagePath encoding:NSUTF8StringEncoding error:nil];
    NSData * resData = [[NSData alloc]initWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    _resultArr = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    //------到这里
    self.frame = CGRectMake(0,0,KSCREEN_WIDTH,KSCREEN_HEIGHT);
    self.backgroundColor = [UIColor chains_colorWithHexString:kBlackColor alpha:0.2f];
    self.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBtnAndcancelBtnClick)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    //设置添加地址的View
    self.addAddressView = [[UIView alloc]init];
    self.addAddressView.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, _defaultHeight);
    self.addAddressView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.addAddressView];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(FitSize(50.0f), FitSize(10.0f), KSCREEN_WIDTH - FitSize(100.0f), FitSize(30.0f))];
    titleLabel.text = _title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = ZYFontSize(16.0f);
    [self.addAddressView addSubview:titleLabel];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancelBtn.frame = CGRectMake(CGRectGetMaxX(self.addAddressView.frame) - FitSize(45.0f), FitSize(10.0f), FitSize(30.0f),FitSize(30.0f));
    cancelBtn.tag = 1;
    [cancelBtn setTitle:@"确定" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = ZYFontSize(15.0f);
    [cancelBtn setTitleColor:[UIColor chains_colorWithHexString:kThemeColor alpha:1.0f] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(tapBtnAndcancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.addAddressView addSubview:cancelBtn];
    return self;
}
-(void)addAnimate{
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.addAddressView.frame = CGRectMake(0, KSCREEN_HEIGHT - self.defaultHeight, KSCREEN_WIDTH, self.defaultHeight);
    }];
}
-(void)tapBtnAndcancelBtnClick{
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.addAddressView.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH,FitSize(200.0f));
    } completion:^(BOOL finished) {
        self.hidden = YES;
        NSMutableString * titleAddress = [[NSMutableString alloc]init];
        NSMutableString * titleID = [[NSMutableString alloc]init];
        NSInteger  count = 0;
        NSString * str = self.titleMarr[self.titleMarr.count - 1];
        if ([str isEqualToString:@"请选择"]) {
            count = self.titleMarr.count - 1;
        }
        else{
            count = self.titleMarr.count;
        }
        for (int i = 0; i< count ; i++) {
            [titleAddress appendString:[[NSString alloc]initWithFormat:@" %@",self.titleMarr[i]]];
            if (i == count - 1) {
                [titleID appendString:[[NSString alloc]initWithFormat:@" %@",self.titleIDMarr[i]]];
            }
            else{
                [titleID appendString:[[NSString alloc]initWithFormat:@"%@ =",self.titleIDMarr[i]]];
            }
        }
        [self.addressDelegate cancelBtnClick:titleAddress titleID:titleID];
    }];
}
-(void)setupTitleScrollView{
    //TitleScrollView和分割线
    self.titleScrollView = [[UIScrollView alloc]init];
    self.titleScrollView.frame = CGRectMake(0,FitSize(45.0f),KSCREEN_WIDTH, _titleScrollViewH);
    [self.addAddressView addSubview:self.titleScrollView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), KSCREEN_WIDTH,FitSize(0.5f))];
    lineView.backgroundColor = [UIColor chains_colorWithHexString:kLineColor alpha:1.0f];
    [self.addAddressView addSubview:(lineView)];
}
-(void)setupContentScrollView{
    //ContentScrollView
    CGFloat y  =  CGRectGetMaxY(self.titleScrollView.frame) + 1;
    self.contentScrollView = [[UIScrollView alloc]init];
    self.contentScrollView.frame = CGRectMake(0, y, KSCREEN_WIDTH, self.defaultHeight - y);
    [self.addAddressView addSubview:self.contentScrollView];
    self.contentScrollView.delegate = self;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
}
-(void)setupAllTitle:(NSInteger)selectId{
    for ( UIView * view in [self.titleScrollView subviews]) {
        [view removeFromSuperview];
    }
    [self.titleBtns removeAllObjects];
    CGFloat btnH = self.titleScrollViewH;
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0,FitSize(1.0f),FitSize(1.0f))];
    _lineLabel.backgroundColor = [UIColor redColor];
    [self.titleScrollView addSubview:(_lineLabel)];
    CGFloat x = FitSize(10.0f);
    for (int i = 0; i < self.titleMarr.count ; i++) {
        NSString   *title = self.titleMarr[i];
        CGFloat titlelenth = title.length * FitSize(15.0f);
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitle:title forState:UIControlStateNormal];
        titleBtn.tag = i;
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleBtn.selected = NO;
        titleBtn.frame = CGRectMake(x, 0, titlelenth, btnH);
        x  = titlelenth + FitSize(10.0f) + x;
        [titleBtn.titleLabel setFont:ZYFontSize(13.0f)];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBtns addObject:titleBtn];
        if (i == selectId) {
            [self titleBtnClick:titleBtn];
        }
        [self.titleScrollView addSubview:(titleBtn)];
        self.titleScrollView.contentSize =CGSizeMake(x, 0);
        self.titleScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScrollView.contentSize = CGSizeMake(self.titleMarr.count * KSCREEN_WIDTH, 0);
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
    }
}
-(void)titleBtnClick:(UIButton *)titleBtn{
    self.radioBtn.selected = NO;
    titleBtn.selected = YES;
    [self setupOneTableView:titleBtn.tag];
    CGFloat x  = titleBtn.tag * KSCREEN_WIDTH;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    self.lineLabel.frame = CGRectMake(CGRectGetMinX(titleBtn.frame), self.titleScrollViewH - FitSize(1.0f),titleBtn.frame.size.width,FitSize(1.0f));
    self.radioBtn = titleBtn;
    self.isclick = YES;
}
-(void)setupOneTableView:(NSInteger)btnTag{
    UITableView  * contentView= self.tableViewMarr[btnTag];
    if  (btnTag == 0) {
        [self getAddressMessageDataAddressID:1 provinceIdOrCityId:0];
    }
    if (contentView.superview != nil) {
        return;
    }
    CGFloat  x= btnTag * KSCREEN_WIDTH;
    contentView.frame = CGRectMake(x, 0, KSCREEN_WIDTH, self.contentScrollView.bounds.size.height);
    contentView.delegate = self;
    contentView.dataSource = self;
    [self.contentScrollView addSubview:(contentView)];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger leftI  = scrollView.contentOffset.x / KSCREEN_WIDTH;
    if (scrollView.contentOffset.x / KSCREEN_WIDTH != leftI){
        self.isclick = NO;
    }
    if (self.isclick == NO) {
        if (scrollView.contentOffset.x / KSCREEN_WIDTH == leftI){
            UIButton * titleBtn  = self.titleBtns[leftI];
            [self titleBtnClick:titleBtn];
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return self.provinceMarr.count;
    }
    else if (tableView.tag == 1) {
        return self.cityMarr.count;
    }
    else if (tableView.tag == 2){
        return self.countyMarr.count;
    }
    else if (tableView.tag == 3){
        return self.townMarr.count;
    }
    else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * AddressAdministerCellIdentifier = @"AddressAdministerCellIdentifier";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:AddressAdministerCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressAdministerCellIdentifier];
    }
    if (tableView.tag == 0) {
        ProvinceModel * provinceModel = self.provinceMarr[indexPath.row];
        cell.textLabel.text = provinceModel.province_name;
    }
    else if (tableView.tag == 1) {
        CityModel *cityModel = self.cityMarr[indexPath.row];
        cell.textLabel.text= cityModel.city_name;
    }
    else if (tableView.tag == 2){
        CountyModel * countyModel  = self.countyMarr[indexPath.row];
        cell.textLabel.text = countyModel.county_name;
    }
    else if (tableView.tag == 3){
        TownModel * townModel  = self.townMarr[indexPath.row];
        cell.textLabel.text = townModel.town_name;
    }
    cell.textLabel.font = ZYFontSize(13.0f);
    cell.textLabel.textColor = [UIColor chains_colorWithHexString:kGrayColor alpha:1.0f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0 || tableView.tag == 1 || tableView.tag == 2){
        if (tableView.tag == 0){
            ProvinceModel *provinceModel = self.provinceMarr[indexPath.row];
            NSString * provinceID = [NSString stringWithFormat:@"%ld",(long)provinceModel.ID];
            //1. 修改选中ID
            if (self.titleIDMarr.count > 0){
                [self.titleIDMarr replaceObjectAtIndex:tableView.tag withObject:provinceID];
            }
            else{
                [self.titleIDMarr addObject:provinceID];
            }
            //2.修改标题
            [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:provinceModel.province_name];
            //请求网络 添加市区
            [self getAddressMessageDataAddressID:2 provinceIdOrCityId:provinceID];
        }
        else if (tableView.tag == 1){
            CityModel * cityModel = self.cityMarr[indexPath.row];
            NSString * cityID = [NSString stringWithFormat:@"%ld",(long)cityModel.ID];
            [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:cityModel.city_name];
            //1. 修改选中ID
            if (self.titleIDMarr.count > 1){
                [self.titleIDMarr replaceObjectAtIndex:tableView.tag withObject:cityID];
            }
            else{
                [self.titleIDMarr addObject:cityID];
            }
            //网络请求，添加县城
            [self getAddressMessageDataAddressID:3 provinceIdOrCityId:cityID];
        }
        else if (tableView.tag == 2) {
            CountyModel * countyModel = self.countyMarr[indexPath.row];
            NSString * countyID = [NSString stringWithFormat:@"%ld",(long)countyModel.ID];
            [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:countyModel.county_name];
            //1. 修改选中ID
            if (self.titleIDMarr.count > 2){
                [self.titleIDMarr replaceObjectAtIndex:tableView.tag withObject:countyID];
            }
            else{
                [self.titleIDMarr addObject:countyID];
            }
            //2.修改标题
            [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:countyModel.county_name];
            //网络请求，添加县城
            [self getAddressMessageDataAddressID:4 provinceIdOrCityId:countyID];
        }
    }
    else if (tableView.tag == 3) {
        TownModel * townModel = self.townMarr[indexPath.row];
        NSString * townID = [NSString stringWithFormat:@"%ld",(long)townModel.ID];
        [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:townModel.town_name];
        //1. 修改选中ID
        if (self.titleIDMarr.count > 3){
            [self.titleIDMarr replaceObjectAtIndex:tableView.tag withObject:townID];
        }
        else{
            [self.titleIDMarr addObject:townID];
        }
        [self setupAllTitle:tableView.tag];
        [self tapBtnAndcancelBtnClick];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return FitSize(35.0f);
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass(touch.view.classForCoder) isEqualToString: @"UITableViewCellContentView"] || touch.view == self.addAddressView || touch.view == self.titleScrollView) {
        return NO;
    }
    return YES;
}
//本地数据
-(void)getAddressMessageDataAddressID:(NSInteger)addressID  provinceIdOrCityId: (NSString *)provinceIdOrCityId{
    if (addressID == 1) {
        [self caseProvinceArr:_resultArr];
    }
    else if(addressID == 2){
        [self caseCityArr:_resultArr withSelectedID:provinceIdOrCityId];
    }
    else if(addressID == 3){
        [self caseCountyArr:_resultArr withSelectedID:provinceIdOrCityId];
    }
    else if(addressID == 4){
        [self caseTownArr:_resultArr withSelectedID:provinceIdOrCityId];
    }
    if (self.tableViewMarr.count >= addressID){
        UITableView* tableView1   = self.tableViewMarr[addressID - 1];
        [tableView1 reloadData];
    }
}
-(void)caseProvinceArr:(NSArray *)provinceArr{
    [self.provinceMarr removeAllObjects];
    if (provinceArr.count > 0){
        for (NSDictionary *dic in provinceArr)
        {
            if ([dic[@"parentid"] isEqualToString:@"0"]) {
                NSDictionary * dic1 = @{
                                        @"id":dic[@"id"],
                                        @"province_name":dic[@"name"]
                                        };
                //
                ProvinceModel *provinceModel = [ProvinceModel mj_objectWithKeyValues:dic1];
                [self.provinceMarr addObject:provinceModel];
            }
        }
    }
    else{
        [self tapBtnAndcancelBtnClick];
    }
}
-(void)caseCityArr:(NSArray *)cityArr withSelectedID:(NSString *)selectedID{
    [self.cityMarr removeAllObjects];
    for (NSDictionary *dic in cityArr) {
        if ([dic[@"parentid"] isEqualToString:selectedID]) {
            NSDictionary * dic1 = @{
                                    @"id":dic[@"id"],
                                    @"city_name":dic[@"name"]
                                    };
            CityModel *cityModel = [CityModel mj_objectWithKeyValues:dic1];
            [self.cityMarr addObject:cityModel];
        }
    }
    if (self.tableViewMarr.count >= 2){
        [self.titleMarr replaceObjectAtIndex:1 withObject:@"请选择"];
        NSInteger index = [self.titleMarr indexOfObject:@"请选择"];
        NSInteger count = self.titleMarr.count;
        NSInteger loc = index + 1;
        NSInteger range = count - index;
        [self.titleMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
        [self.tableViewMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
    }
    else{
        UITableView * tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,FitSize(200.0f)) style:UITableViewStylePlain];
        tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView2.tag = 1;
        [self.tableViewMarr addObject:tableView2];
        [self.titleMarr addObject:@"请选择"];
    }
    if (self.cityMarr.count > 0) {
        [self setupAllTitle:1];
    }
    else{
        //没有对应的市
        if (self.tableViewMarr.count >= 2){
            [self.titleMarr removeObjectsInRange:NSMakeRange(1, self.titleMarr.count - 2)];
            [self.tableViewMarr removeObjectsInRange:NSMakeRange(1, self.tableViewMarr.count - 2)];
        }
        [self setupAllTitle:0];
        [self tapBtnAndcancelBtnClick];
    }
}
-(void)caseCountyArr:(NSArray *)countyArr withSelectedID:(NSString *)selectedID{
    [self.countyMarr removeAllObjects];
    for (NSDictionary *dic in countyArr) {
        if ([dic[@"parentid"] isEqualToString:selectedID]) {
            NSDictionary * dic1 = @{
                                    @"id":dic[@"id"],
                                    @"county_name":dic[@"name"]
                                    };
            //
            CountyModel *countyModel =  [CountyModel mj_objectWithKeyValues:dic1];
            [self.countyMarr addObject:countyModel];
        }
    }
    if (self.tableViewMarr.count >= 3){
        [self.titleMarr replaceObjectAtIndex:2 withObject:@"请选择"];
        NSInteger index = [self.titleMarr indexOfObject:@"请选择"];
        NSInteger count = self.titleMarr.count;
        NSInteger loc = index + 1;
        NSInteger range = count - index;
        [self.titleMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
        [self.tableViewMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
    }
    else{
        UITableView * tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,FitSize(200.0f)) style:UITableViewStylePlain];
        tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView2.tag = 2;
        [self.tableViewMarr addObject:tableView2];
        [self.titleMarr addObject:@"请选择"];
    }
    if (self.countyMarr.count > 0){
        [self setupAllTitle:2];
    }
    else{
        //没有对应的县
        if (self.tableViewMarr.count >= 3){
            [self.titleMarr removeObjectsInRange:NSMakeRange(2, self.titleMarr.count - 3)];
            [self.tableViewMarr removeObjectsInRange:NSMakeRange(2, self.tableViewMarr.count - 3)];
        }
        [self setupAllTitle:1];
        [self tapBtnAndcancelBtnClick];
    }
}
-(void)caseTownArr:(NSArray *)countyArr withSelectedID:(NSString *)selectedID{
    [self.townMarr removeAllObjects];
    for (NSDictionary *dic in countyArr) {
        if ([dic[@"parentid"] isEqualToString:selectedID]) {
            NSDictionary * dic1 = @{
                                    @"id":dic[@"id"],
                                    @"town_name":dic[@"name"]
                                    };
            //
            TownModel *townModel =  [TownModel mj_objectWithKeyValues:dic1];
            [self.townMarr addObject:townModel];
        }
    }
    if (self.tableViewMarr.count > 3){
        [self.titleMarr replaceObjectAtIndex:3 withObject:@"请选择"];
    }
    else{
        UITableView * tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,FitSize(200.0f)) style:UITableViewStylePlain];
        tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView2.tag = 3;
        [self.tableViewMarr addObject:tableView2];
        [self.titleMarr addObject:@"请选择"];
    }
    if (self.townMarr.count > 0){
        [self setupAllTitle:3];
    }
    else{
        //没有对应的乡镇
        if (self.tableViewMarr.count >= 4){
            [self.titleMarr removeObjectsInRange:NSMakeRange(3, self.titleMarr.count - 4)];
            [self.tableViewMarr removeObjectsInRange:NSMakeRange(3, self.tableViewMarr.count - 4)];
        }
        [self setupAllTitle:2];
        [self tapBtnAndcancelBtnClick];
    }
}
//(以下注释部分是网络请求)
//-(void)getAddressMessageDataAddressID:(NSInteger)addressID  provinceIdOrCityId: (NSString *)provinceIdOrCityId{
//        NSString * addressUrl = [[NSString alloc]init];
//        NSDictionary *parameters = [[NSDictionary alloc]init];
//        NSString * UserID = [[NSString alloc]initWithFormat:@"%ld",self.userID];
//        if (addressID == 1) {
//            //获取省份的URL
//            addressUrl = @"getProvinceAddressUrl";
//            //请求省份需要传递的参数
//            parameters = @{@"user_id" : UserID};
//        } else if(addressID == 2){
//            //获取市区的URL
//            addressUrl = @"getCityAddressUrl";
//            //请求市区需要传递的参数
//            parameters = @{@"province_id" : provinceIdOrCityId,
//                           @"user_id" : UserID};
//        }
//        else if(addressID == 3){
//            //获取县的URL
//            addressUrl = @"getCountyAddressUrl";
//            //请求县需要传递的参数
//            parameters = @{@"city_id" : provinceIdOrCityId,
//                           @"user_id" : UserID};
//        }
//    //网络请求
//    [HttpRequest requestWithURLString:addressUrl parameters:parameters type:HttpRequestTypePost success:^(id responseObject) {
//        if (responseObject != nil)
//        {
//            NSDictionary * dic = responseObject;
//            //成功
//            if([dic[@"statues"] isEqualToString:@"1"]){
//                NSArray *arr = [[NSArray alloc]init];
//                switch (addressID) {
//                case 1:
//                    //拿到省列表
//                        arr =  dic[@"data"];
//                        [self caseProvinceArr:arr];
//                case 2:
//                    //拿到市列表
//                    arr = dic[@"data"];
//                        [self caseCityArr:arr];
//                case 3:
//                    //拿到县列表
//                    arr = dic[@"data"];
//                        [self caseCountyArr:arr];
//
//                default:
//                    break;
//                }
//                if (self.tableViewMarr.count >= addressID){
//                    UITableView * tableView1  = self.tableViewMarr[addressID - 1];
//                    [tableView1 reloadData];
//                }
//            }
//            else{
//                NSLog(@"请求数据失败");
//            }
//        }
//        else{
//            NSLog(@"请求数据失败");
//        }
//    } failure:^(NSError *error) {
//          NSLog(@"网络请求失败");
//    }];
//}
//-(void)caseProvinceArr:(NSArray *)provinceArr{
//    if (provinceArr.count > 0){
//        [self.provinceMarr removeAllObjects];
//        for (int i = 0; i < provinceArr.count; i++) {
//            NSDictionary *dic1 = provinceArr[i];
//            ProvinceModel *provinceModel =  [ProvinceModel yy_modelWithDictionary:dic1];
//            [self.provinceMarr addObject:provinceModel];
//        }
//    }else{
//        [self tapBtnAndcancelBtnClick];
//    }
//}
//-(void)caseCityArr:(NSArray *)cityArr{
//    if (cityArr.count > 0){
//        [self.cityMarr removeAllObjects];
//        for (int i = 0; i < cityArr.count; i++) {
//            NSDictionary *dic1 = cityArr[i];
//            CityModel *cityModel = [CityModel yy_modelWithDictionary:dic1];
//            [self.cityMarr addObject:cityModel];
//        }
//        if (self.tableViewMarr.count >= 2){
//            [self.titleMarr replaceObjectAtIndex:1 withObject:@"请选择"];
//            NSInteger index = [self.titleMarr indexOfObject:@"请选择"];
//            NSInteger count = self.titleMarr.count;
//            NSInteger loc = index + 1;
//            NSInteger range = count - index;
//            [self.titleMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
//            [self.tableViewMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
//        }
//        else{
//            UITableView * tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 200) style:UITableViewStylePlain];
//            tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
//            tableView2.tag = 1;
//            [self.tableViewMarr addObject:tableView2];
//            [self.titleMarr addObject:@"请选择"];
//        }
//        [self setupAllTitle:1];
//    }
//    else{
//        //没有对应的市
//        if (self.tableViewMarr.count >= 2){
//            [self.titleMarr removeObjectsInRange:NSMakeRange(1, self.titleMarr.count - 2)];
//            [self.tableViewMarr removeObjectsInRange:NSMakeRange(1, self.tableViewMarr.count - 2)];
//        }
//        [self setupAllTitle:0];
//        [self tapBtnAndcancelBtnClick];
//    }
//}
//
//-(void)caseCountyArr:(NSArray *)countyArr{
//    if (countyArr.count > 0){
//        [self.countyMarr removeAllObjects];
//        for (int i = 0; i < countyArr.count; i++) {
//            NSDictionary *dic1 = countyArr[i];
//            CountyModel *countyModel = [CountyModel yy_modelWithDictionary:dic1];
//            [self.countyMarr addObject:countyModel];
//        }
//        if (self.tableViewMarr.count >= 3){
//            [self.titleMarr replaceObjectAtIndex:2 withObject:@"请选择"];
//            NSInteger index = [self.titleMarr indexOfObject:@"请选择"];
//            NSInteger count = self.titleMarr.count;
//            NSInteger loc = index + 1;
//            NSInteger range = count - index;
//            [self.titleMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
//            [self.tableViewMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
//        }
//        else{
//            UITableView * tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 200) style:UITableViewStylePlain];
//            tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
//            tableView2.tag = 2;
//            [self.tableViewMarr addObject:tableView2];
//            [self.titleMarr addObject:@"请选择"];
//        }
//        [self setupAllTitle:2];
//    }
//    else{
//        //没有对应的县
//        if (self.tableViewMarr.count >= 3){
//            [self.titleMarr removeObjectsInRange:NSMakeRange(2, self.titleMarr.count - 3)];
//            [self.tableViewMarr removeObjectsInRange:NSMakeRange(2, self.tableViewMarr.count - 3)];
//        }
//        [self setupAllTitle:1];
//        [self tapBtnAndcancelBtnClick];
//    }
//}
//
//-(void)caseTownArr:(NSArray *)townArr{
//    if (townArr.count > 0){
//        [self.townMarr removeAllObjects];
//        for (int i = 0; i < townArr.count; i++) {
//            NSDictionary *dic1 = townArr[i];
//            TownModel *townModel = [TownModel yy_modelWithDictionary:dic1];
//            [self.townMarr addObject:townModel];
//        }
//        if (self.tableViewMarr.count > 3){
//            [self.titleMarr replaceObjectAtIndex:3 withObject:@"请选择"];
//            if (self.tableViewMarr.count > 4){
//                [self.titleMarr removeLastObject];
//                [self.tableViewMarr removeLastObject];
//            }
//        }
//        else{
//            UITableView * tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 200) style:UITableViewStylePlain];
//            tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
//            tableView2.tag = 3;
//            [self.tableViewMarr addObject:tableView2];
//            [self.titleMarr addObject:@"请选择"];
//        }
//        [self setupAllTitle:3];
//    }
//    else{
//        //没有对应的乡镇
//        if (self.tableViewMarr.count >= 4){
//            [self.titleMarr removeObjectsInRange:NSMakeRange(3, self.titleMarr.count - 4)];
//            [self.tableViewMarr removeObjectsInRange:NSMakeRange(3, self.tableViewMarr.count - 4)];
//        }
//        [self setupAllTitle:2];
//        [self tapBtnAndcancelBtnClick];
//    }
//}
@end