//
//  YDNearbyRootViewController.m
//  ydhyk
//
//  Created by 120v on 2016/10/21.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDNearbyRootViewController.h"
/** 药店List*/
#import "YDListTableViewController.h"
/** 加入会员步骤*/
#import "HJoinLeadViewController.h"
/** 搜索*/
#import "YDSearchViewController.h"
/** 地图：自定义标记*/
#import "MyNormalAnnotationView.h"
/** 药店数据模型*/
#import "YDSearchModel.h"
/** 二维码页面*/
#import "HQRScanViewController.h"
#import "YDHYK-Swift.h"

@interface YDNearbyRootViewController ()
/**  百度基础地图 */
@property(nonatomic,strong) BMKMapView *mapView;
/**  百度定位服务 */
@property(nonatomic,strong) BMKLocationService *locService;
/**  顶部搜索 */
@property (nonatomic, strong) UIButton *searchButton;
/**  左边分类按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/**  右边播放历史 */
@property (nonatomic, strong) UIButton *rightBtn;
/** 底部位置详情视图*/
@property (nonatomic, strong) YDDetailView *detailView;
/** 判断定位状态视图*/
@property (nonatomic, strong) UIView *openLocationView;
/** 保存用户位置*/
@property (nonatomic, assign) CLLocationCoordinate2D userLocation;
/** 保存是否为第一次打开百度地图*/
@property (nonatomic, assign) BOOL isFirstOpenMap;
/** 药店数据*/
@property (nonatomic, strong) NSMutableArray *dataModelArray;
/** 标记索引*/
@property (nonatomic, assign) int indexPath;
/** 保存上一次标记*/
@property (nonatomic, assign) BMKPointAnnotation *lastAnnotation;
/** 点击是否为地图空白区*/
@property (nonatomic, assign) BOOL isMapBlank;

@end

@implementation YDNearbyRootViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor zx_assistColor];
    //1.标记索引
    _indexPath = 0;
    
    //2.保存是否为第一次打开百度地图
    _isFirstOpenMap = FALSE;
    _isMapBlank = FALSE;
    
    //3.自定义导航栏按钮
    [self setupNavgationView];
    
    //4.判断用户定位是否可用,如果定位可用则开启百度定位服务
    [self judgmentLocationServiceEnabled];
    
    //5.监听定位是否开启
    [self addObserverLocation];
    
    //6.地图
    self.view = self.mapView;
    
    //7.顶部开启定位弹窗
    [self setupOpenLocationView];

    //8.精度
    [self customLocationAccuracyCircle];
    
    //9.添加底部药店详情
    [self addDetailView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden=YES;
    [self zx_setNavBarBackgroundColor:[UIColor zx_navbarColor]];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.locService.delegate = self;
    [self.locService startUserLocationService];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.locService.delegate = nil;
}

#pragma mark - 监听定位是否开启
-(void)addObserverLocation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obverserLocationStatus:) name:ZXNOTICE_LOCATION_ISOPEN object:nil];
}

#pragma mark 监听方法
-(void)obverserLocationStatus:(NSNotification *)information{
    NSString *isOpenLocation = information.object;
    [self showTopViewByLocationStatus:isOpenLocation];
}

#pragma mark 判断顶部视图是否显示
-(void)showTopViewByLocationStatus:(NSString *)isOpenLocation{
    if ([isOpenLocation isEqualToString:@"True"]) {
        //1.开启动画
        [self openLocationViewAnAnimation:TRUE];
        //2.
        [self.locService startUserLocationService];
        //3.显示用户位置
        [self.mapView setShowsUserLocation:YES];
    }else{
        [self.locService stopUserLocationService];
        [self.mapView setShowsUserLocation:YES];
        [self openLocationViewAnAnimation:FALSE];
        
        //默认位置为公司
        CLLocationCoordinate2D userLo;
        userLo.latitude = [ZX_Detail_Latitude doubleValue];
        userLo.longitude = [ZX_Detail_Longitude doubleValue];
        self.userLocation = userLo;
        
        //
        [self httpRequestForPharmacyList];
    }
    //4.开启精度圈
    [self customLocationAccuracyCircle];

}

#pragma mark - 导航栏
#pragma mark 自定义导航栏按钮
-(void)setupNavgationView{
    //关闭
    [self zx_addLeftBarItemsWithTexts:@[@"关闭"] font:nil color:nil];
    //列表
    [self zx_addRightBarItemsWithTexts:@[@"列表"] font:nil color:nil];
    //搜索
    [self creatSearchView];
}

#pragma mark 自定义导航栏中间搜索按钮
-(void)creatSearchView{
    //点击搜索
    self.searchButton.x = CGRectGetMaxX(self.leftBtn.frame)+15;
    self.searchButton.y = 7;
    self.searchButton.height = 30;
    self.searchButton.width = ZX_BOUNDS_WIDTH-2*self.searchButton.x;
    self.searchButton.backgroundColor = [UIColor whiteColor];
    [self.searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchButton setImage:[UIImage imageNamed:@"icon-search"] forState:UIControlStateNormal];
    [self.searchButton setTitle:@" 搜索药店、医馆" forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor zx_sub2TextColor] forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.searchButton.layer.cornerRadius = 5.0;
    self.searchButton.layer.masksToBounds = YES;
    self.navigationItem.titleView = self.searchButton;
}

#pragma mark 关闭
- (void)zx_leftBarButtonActionsIndex:(NSInteger)index{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 列表
-(void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    YDListTableViewController *listVC = [[YDListTableViewController alloc]initWithNibName:@"YDListTableViewController" bundle:nil];
    listVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark - 判断定位是否可用
-(void)judgmentLocationServiceEnabled{
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [self showTopViewByLocationStatus:appDelegate.isOpenLoction];
}

#pragma mark - 顶部开启定位弹窗
-(void)setupOpenLocationView{
    [self.mapView addSubview:self.openLocationView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 120, 25)];
    titleLabel.text = @"开启定位功能";
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor whiteColor];
    [self.openLocationView addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+5  , ZX_BOUNDS_WIDTH - 90, 25)];
    detailLabel.text = @"定位功能关闭了，请开启获得完整体验";
    detailLabel.font = [UIFont systemFontOfSize:13];
    detailLabel.textColor = [UIColor whiteColor];
    [self.openLocationView addSubview:detailLabel];
    
    UIButton *openLocationButton = [[UIButton alloc]init];
    [openLocationButton setTitle:@"开启" forState:UIControlStateNormal];
    openLocationButton.width = 70.0;
    openLocationButton.height = 44;
    openLocationButton.x = ZX_BOUNDS_WIDTH - 10 - openLocationButton.width;
    openLocationButton.centerY =self.openLocationView.centerY;
    openLocationButton.titleLabel.textAlignment = NSTextAlignmentRight;
    openLocationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    openLocationButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    openLocationButton.backgroundColor = [UIColor clearColor];
    [self.openLocationView addSubview:openLocationButton];
    [openLocationButton addTarget:self action:@selector(openLoctionClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 是否开启定位视图淡入动画
-(void)openLocationViewAnAnimation:(BOOL)isHidden{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;   //时间间隔
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    if (isHidden == TRUE) {
        animation.fillMode = kCAFillModeRemoved;
        animation.type = kCATransitionReveal;//动画效果
        animation.subtype = kCATransitionFromTop;//动画方向
        [self.openLocationView.layer addAnimation:animation forKey:@"animation"];
        self.openLocationView.alpha = 0;
    }else if(isHidden == FALSE){
        animation.fillMode = kCAFillModeForwards;
        animation.type = kCATransitionMoveIn;         //动画效果
        animation.subtype = kCATransitionFromBottom;   //动画方向
        [self.openLocationView.layer addAnimation:animation forKey:@"animation"];
        self.openLocationView.alpha = 1;
    }
}

#pragma mark - 点击开启定位按钮 ->设置定位服务
-(void)openLoctionClick:(UIButton *)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) {
        
    }];
}

#pragma mark - Map
#pragma mark 自定义精度圈
- (void)customLocationAccuracyCircle{

    CLLocation *userLocation = ((AppDelegate *)[UIApplication sharedApplication].delegate).userlocation;
    
    //1.获取用户位置
    CLLocationCoordinate2D center;
    center.latitude = userLocation.coordinate.latitude;
    center.longitude = userLocation.coordinate.longitude;
    
    //2.设置地图中心点
    [self setUserLocationWithCenter:center];
}

#pragma mark 设置地图中心点
-(void)setUserLocationWithCenter:(CLLocationCoordinate2D)center{
    //2.指定经纬度的跨度(跨度越小,显示越详细)
    BMKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    //3.将用户当前位置作为显示区域的中心点,并且指定需要显示的跨度范围
    BMKCoordinateRegion region;
    region.center = center;
    region.span = span;
    //4.设置显示区域
    [self.mapView setRegion:region animated:YES];
}

#pragma mark 添加普通标注
- (void)addNormalAnnotation{
    _indexPath = 0;
    
    //
    [_mapView removeAnnotations:_mapView.annotations];
    
    //
    NSMutableArray *AnnoArray = [NSMutableArray arrayWithCapacity:self.dataModelArray.count];
    for (int i = 0; i<self.dataModelArray.count; i++) {
        YDSearchModel *model = self.dataModelArray[i];
        BMKPointAnnotation *Annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = model.latitude.floatValue;
        coor.longitude = model.longitude.floatValue;
        Annotation.coordinate = coor;
        [AnnoArray addObject:Annotation];
    }
    [self.mapView addAnnotations:AnnoArray];
    
    
    //默认选中距用户最近的药店
    if (self.isLocationButtonClick == NO) {//从列表点击定位
        self.lastAnnotation = AnnoArray[0];
        [self.mapView selectAnnotation:AnnoArray[0] animated:YES];
    }else{//从卡包点击定位按钮
        [self selectedAnnotationWithArray:self.modelArray_store];
    }
}

#pragma mark - 添加addDetailView
-(void)addDetailView{
    self.detailView.width = ZX_BOUNDS_WIDTH;
    self.detailView.height = ZX_BOUNDS_HEIGHT - self.mapView.height - 64;
    self.detailView.x = 0;
    self.detailView.y = CGRectGetMaxY(self.mapView.frame);
    [self.view addSubview:self.detailView];
}

#pragma mark - SearchButton
-(void)searchButtonAction:(UIButton *)sender{
    YDSearchViewController *searchVC = [[YDSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

#pragma mark - BMKMapViewDelegate
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    if([annotation isKindOfClass:[BMKPointAnnotation class]]){
        //1.自定义annotation
        NSString *NormalAnnotationViewID = @"NormalAnnotation";
        MyNormalAnnotationView *annotationView =(MyNormalAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NormalAnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[MyNormalAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:NormalAnnotationViewID];
            //不显示点击标注后的视图
            annotationView.canShowCallout = NO;
        }
        
        //2.取值
        YDSearchModel *model = [self.dataModelArray objectAtIndex:_indexPath];
        
        //3.自定义标注
        UIImage *image = nil;
        if (model.isChineseMedicine.integerValue == 1) {//中医馆
            image = [UIImage imageNamed:@"yg-small"];
        }else{//药店
            image = [UIImage imageNamed:@"yd-small"];
        }
        annotationView.size = image.size;
        annotationView.normalImage = image;
        annotationView.isChineseMedicine = model.isChineseMedicine;

        //4.设置索引
        annotationView.uid = model.uid;
        if (_indexPath < self.dataModelArray.count -1) {
            _indexPath++;
        }
        [annotationView setAnnotation:annotation];
        return annotationView;
    }
    return nil;
}

-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
    _isMapBlank = FALSE;
    [self mapView:_mapView didDeselectAnnotationView:[_mapView viewForAnnotation:self.lastAnnotation]];
    
    //1.切换标注图标
    if ([view isKindOfClass:[MyNormalAnnotationView class]]) {
        MyNormalAnnotationView *normalView = (MyNormalAnnotationView *)view;
        normalView.normalImage = nil;
        UIImage *image = nil;
        if (normalView.isChineseMedicine.integerValue == 1) {//中医馆
            image = [UIImage imageNamed:@"yg-big"];
        }else{//药店
            image = [UIImage imageNamed:@"yd-big"];
        }
        normalView.normalImage = image;
        
        _lastAnnotation =(BMKPointAnnotation *)normalView.annotation;
        
        //2.刷新底部视图数据
        NSMutableArray *dataArray = [NSMutableArray array];
        for (YDSearchModel *model in self.dataModelArray) {
            if (model.uid.integerValue == normalView.uid.integerValue) {
                 [dataArray addObject:model];
                self.detailView.dataArray = dataArray;
            }
        }
    }
}

-(void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    
    if ([view isKindOfClass:[MyNormalAnnotationView class]]&& _isMapBlank == FALSE) {
        MyNormalAnnotationView *normalView = (MyNormalAnnotationView *)view;
        UIImage *image = nil;
        if (normalView.isChineseMedicine.integerValue == 1) {//中医馆
            image = [UIImage imageNamed:@"yg-small"];
        }else{//药店
            image = [UIImage imageNamed:@"yd-small"];
        }
        normalView.normalImage = image;
    }
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    BMKAnnotationView *lastView = [self.mapView viewForAnnotation:_lastAnnotation];
    _isMapBlank = TRUE;
    if (lastView.isSelected == NO) {
        [self mapView:self.mapView didSelectAnnotationView:[self.mapView viewForAnnotation:_lastAnnotation]];
    }
}

#pragma mark - BMKLocationServiceDelegate
/**用户方向更新后，会调用此函数 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    [_mapView updateLocationData:userLocation];
}

/**用户位置更新后，会调用此函数 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    [_mapView updateLocationData:userLocation];
    self.userLocation = userLocation.location.coordinate;
    if (userLocation.location.coordinate.latitude && userLocation.location.coordinate.longitude) {
        if (self.isFirstOpenMap == FALSE) {//首次进入地图获取位置成功后请求数据
            //附近药店请求
            [self httpRequestForPharmacyList];
            self.isFirstOpenMap = TRUE;
        }
    }
}

#pragma mark - Setter
#pragma mark 刷新底部视图/定位(列表点击定位)
-(void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    
    [self selectedAnnotationWithArray:modelArray];
}

#pragma mark 刷新底部视图/定位(卡包点击定位)
-(void)setModelArray_store:(NSArray *)modelArray_store{
    //
    _modelArray_store = modelArray_store;
}

#pragma mark 取消和选中
-(void)selectedAnnotationWithArray:(NSArray *)modelArray{
    YDSearchModel *model = modelArray.firstObject;
    CLLocationCoordinate2D coor;
    coor.latitude = model.latitude.floatValue;
    coor.longitude = model.longitude.floatValue;
    
    //2.取消选中
    NSArray *annoArray = self.mapView.annotations;
    __block  BMKPointAnnotation *deselectAnno = nil;
    [annoArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        deselectAnno = obj;
        if (deselectAnno.coordinate.latitude == _lastAnnotation.coordinate.latitude && deselectAnno.coordinate.longitude == _lastAnnotation.coordinate.longitude) {
            *stop = true;
            [self mapView:self.mapView didDeselectAnnotationView:[self.mapView viewForAnnotation:deselectAnno]];
        }
    }];
    
    //3.选中
    NSArray *selectArray = self.mapView.annotations;
    __block  BMKPointAnnotation *selectAnno = nil;
    [selectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        selectAnno = obj;
        if (selectAnno.coordinate.latitude == coor.latitude && selectAnno.coordinate.longitude == coor.longitude) {
            *stop = true;
            
            //3.1 选中
            [self mapView:self.mapView didSelectAnnotationView:[self.mapView viewForAnnotation:selectAnno]];
            
            //3.2 获取用户位置
            CLLocationCoordinate2D center;
            center.latitude = selectAnno.coordinate.latitude;
            center.longitude = selectAnno.coordinate.longitude;
            
            //3.3 设置地图中心点
            [self setUserLocationWithCenter:center];
            
            //3.4 保存上一次的选中标准
            _lastAnnotation = selectAnno;
        }
    }];
}

#pragma mark - YDDetailDelegate
#pragma mark 加入会员
-(void)didDetailViewJoinMemberButton:(UIButton *)sender withDataModel:(YDSearchModel *)model{
    if (model.isMember.integerValue == 1) {//商城
        if (![[[ZXGlobalData shareInstance] userTelephone] isEqualToString:ZXAPP_Common_TestAccount]) {
            ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:model.uid memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];

            [self.navigationController pushViewController:webStore animated:true];
        }
    }else if (model.isMember.integerValue == 0){//加入会员
        [HJoinLeadViewController checkShowWithCompletion:^{
            HQRScanViewController * qrVC = [[HQRScanViewController alloc] init];
            [self.navigationController pushViewController:qrVC animated:true];
        }];
    }
}

#pragma mark 导航
-(void)didDetailViewNavigationButton:(UIButton *)sender withDataModel:(YDSearchModel *)model{
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://"]]){//百度地图APP

        BMKOpenDrivingRouteOption *opt = [[BMKOpenDrivingRouteOption alloc] init];
        //opt.appName = @"SDK调起Demo";
        opt.appScheme = @"resonydhyk://";
        
        //1.初始化起点节点
        CLLocationCoordinate2D startCoor = self.userLocation;
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        //start.name = self.currentLocationName;
        start.pt = startCoor;
        opt.startPoint = start;
        
        //2.初始化终点节点
        CLLocationCoordinate2D destinationCoor;
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        if (model.latitude.floatValue && model.longitude.floatValue) {
            destinationCoor.latitude = model.latitude.floatValue;
            destinationCoor.longitude =  model.longitude.floatValue;
            end.pt =destinationCoor;
        }else if(model.address.length){
            end.name = model.address;
        }
        opt.endPoint = end;
        
        //3.打开百度地图导航
        [BMKOpenRoute openBaiduMapDrivingRoute:opt];
    }else{//调启Web_iOS百度地图
        CLLocationCoordinate2D destinationCoor;
        destinationCoor.latitude = model.latitude.floatValue;
        destinationCoor.longitude =  model.longitude.floatValue;
    
        NSString *urlString = [NSString stringWithFormat:@"https://api.map.baidu.com/direction?origin=latlng:%f,%f|name:起点&destination=latlng:%f,%f|name:终点&mode=driving&region=%@&output=html&src=screson|YDHYK",self.userLocation.latitude, self.userLocation.longitude,destinationCoor.latitude,destinationCoor.longitude,model.cityName];
        NSURL *navURL = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        [[UIApplication sharedApplication] openURL:navURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) {}];
    }
//    else{
//        //跳到app store
//        NSString *urlString =[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/bai-du-tu-shou-ji-tu-lu-xian/id452186370?mt=8"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) {
//        }];
//    }
}

#pragma mark 打电话
-(void)didDetailViewTelephoneButton:(UIButton *)sender withDataModel:(YDSearchModel *)model{
    
    if ([model.tel isKindOfClass:[NSString class]] && model.tel.length){
        [ZXCommonUtils openCallWithTelNum:model.tel failBlock:^{
            [ZXAlertUtils showAAlertMessage:@"该设备不支持拨打电话功能" title:@"提示" buttonText:@"知道了" buttonAction:nil];
        }];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"无相关联系方式" delay:1.5];
    }
}

#pragma mark - HTTP
#pragma mark  附近药店、中医馆清单
-(void)httpRequestForPharmacyList{
    [self.dataModelArray removeAllObjects];
    _dataModelArray = nil;
    
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    [dicParams setObject:[NSString stringWithFormat:@"%f",self.userLocation.latitude] forKey:@"latitude"];
    [dicParams setObject:[NSString stringWithFormat:@"%f",self.userLocation.longitude] forKey:@"longitude"];
    
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:2.0];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Pharmacy_List) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
//        [ZXHUD MBHideForView:self.view animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {//
                id obj = content[@"data"];
                if ([obj isKindOfClass:[NSArray class]]) {
                    
                    //1.模型转换
                    self.dataModelArray = [YDSearchModel mj_objectArrayWithKeyValuesArray:obj];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //2.标注
                        [self addNormalAnnotation];
                        
                        //3.设置底部视图数据
                        if (self.isLocationButtonClick == FALSE) {//如果为列表页面点击定位,则不再更新底部视图
                            NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:1];
                            YDSearchModel *model = self.dataModelArray[0];
                            [array addObject:model];
                            self.detailView.dataArray = array;
                        }
                    });
                    
                    //4.保存数据库
                    __block YDSearchModel *model = nil;
                    [self.dataModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        model = obj;
                        model.distanceF = model.distance.floatValue;
                    }];
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        [YDSearchModel clearTable];
                        [YDSearchModel saveObjects:self.dataModelArray];
                    });
                }
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark - Getter
-(BMKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT - 133-64)];
        _mapView.delegate = self;
        _mapView.userTrackingMode = BMKUserTrackingModeNone;
        _mapView.mapType = BMKMapTypeStandard;
        _mapView.zoomEnabled=YES;
        _mapView.scrollEnabled = YES;
        _mapView.showsUserLocation = YES;//显示定位图层
    }
    return _mapView;
}

-(BMKLocationService *)locService{
    if (!_locService) {
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
    }
    return _locService;
}

-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [[UIButton alloc]init];
    }
    return _searchButton;
}

-(YDDetailView *)detailView{
    if (!_detailView) {
        _detailView = [[YDDetailView alloc]init];
        _detailView.delegate = self;
    }
    return _detailView;
}

-(UIView *)openLocationView{
    if (!_openLocationView) {
        _openLocationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 64)];
        _openLocationView.backgroundColor = ZXRGBA_COLOR(242, 146, 82,0.8);
    }
    return _openLocationView;
}

-(NSMutableArray *)dataModelArray{
    if (!_dataModelArray) {
        _dataModelArray = [[NSMutableArray alloc]initWithCapacity:30];
    }
    return _dataModelArray;
}

#pragma mark - dealloc
-(void)releaseBMKMapView{
    [_mapView removeAnnotations:_mapView.annotations];
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
    _mapView.delegate = nil;
    _locService.delegate = nil;
    _mapView = nil;
    _locService = nil;
    _openLocationView =nil;
    _detailView = nil;
    _detailView.delegate = nil;
    [_mapView removeFromSuperview];
    [_detailView removeFromSuperview];
    _indexPath = 0;
    _isFirstOpenMap = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)dealloc{
    NSLog(@"%s",__func__);
    [self releaseBMKMapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
