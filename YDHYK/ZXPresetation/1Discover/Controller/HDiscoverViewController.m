//
//  HDiscoverViewController.m
//  ZXStructure
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDiscoverViewController.h"
#import "HJoinLeadViewController.h"
#import "HMyQRCodeViewController.h"
#import "HSmartToolsViewController.h"
#import "ZXCheckUpdate.h"

#import "HDiscoverTableViewDelegate.h"
#import "HDiscoverTableViewDataSource.h"
#import "HDiscoverCollectionViewDataSource.h"
#import "HDiscoverCollectionViewDelegateFlowLayout.h"

#import "ZXDiscoverViewModel.h"
#import "ZXDiscoverModel.h"

#import "HQRScanViewController.h"
#import "HItemModel.h"
#import "Base64.h"
#import "YDUpdateUserInformation.h"
#import "AppDelegate.h"

#import "ZXJoinMemberViewModel.h"
#import "HJoinSuccessViewController.h"

#import "YDHYK-Swift.h"


typedef enum : NSUInteger {
    HScrollUP,
    HScrollDOWN
} HScollDirection;

@interface HDiscoverViewController ()
{
    CGFloat oldOffsetY;
    CGFloat newOffsetY;
    CGFloat currentOffsetY;
    BOOL startTrackingScroll;//监测滚动
    BOOL isDecelerating;//自动滚动
    NSInteger currentPage;
    NSInteger totalPage;
    HScollDirection direction;
    
    NSMutableArray<ZXDiscoverModel *> * arrListModels;
    
    BOOL firstCheckEnd;
    BOOL isLoadingPromotionList;
}

@property (nonatomic,strong) CLLocation * location;

@property (strong, nonatomic) IBOutlet HDiscoverCollectionViewDelegateFlowLayout *collectionViewDelegate;
@property (strong, nonatomic) IBOutlet HDiscoverCollectionViewDataSource *ccDataSource;

@property (strong, nonatomic) IBOutlet HDiscoverTableViewDelegate *tblDelegate;
@property (strong, nonatomic) IBOutlet HDiscoverTableViewDataSource *tblDataSource;


//视图顺序
//menuview 大菜单
//tableview
//navView
//navView 在 tableview 之上避免事件被遮挡
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *navButtons;//NavBar 按钮

@property (weak, nonatomic) IBOutlet UIView *navView;//自定义NavBar
@property (weak, nonatomic) IBOutlet UIView *navContentView;//存放按钮和文字
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblDiscoverList;
@property (weak, nonatomic) IBOutlet UIView *menuView;//大菜单项俯视图
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewTools;//大菜单

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ccTop;//大菜单上边缘位置

@end

@implementation HDiscoverViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:false];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:true animated:false];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self zx_setNavBarBackgroundColor:[UIColor zx_navbarColor]];
    if (firstCheckEnd == false && isLoadingPromotionList == false) {
        [self loadListDataShowHUD:true];
        [self updateUserInfo];
    }else if ((!arrListModels || arrListModels.count == 0) && firstCheckEnd) {
        [self loadListDataShowHUD:false];
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (kCLAuthorizationStatusAuthorizedAlways == status || kCLAuthorizationStatusAuthorizedWhenInUse == status) {
            [[ZXLocationUtils shareInstance] checkCurrentLoaction:^(BOOL success, CLLocation *location) {
                if (success) {
                    _location = location;
                }else{
                    _location = [[CLLocation alloc] initWithLatitude:ZX_LATITUDE longitude:ZX_LONGITUDE];
                }
                [self pasteBoardCheck];
            }];
        }else{
            [self locationDisable];
        }
    }else{
        [self locationDisable];
    }
}

- (void)locationDisable{
    [ZXAlertUtils showAAlertMessage:@"位置信息不可用,可以在设置中开启" title:@"提示" buttonTexts:@[@"知道了"] buttonAction:^(int buttonIndex) {
        [[ZXLocationUtils shareInstance] checkCurrentLoaction:^(BOOL success, CLLocation *location) {
            if (success) {
                _location = location;
                [self pasteBoardCheck];
            }else{
                _location = [[CLLocation alloc] initWithLatitude:ZX_LATITUDE longitude:ZX_LONGITUDE];
                [self pasteBoardCheck];
            }
        }];
    }];
}

- (void)zx_checkupdate{
    //检测更新
    [ZXCheckUpdate checkUpdate:^(BOOL needUpdate, NSString *updateURL,BOOL appStoreType) {
        if (needUpdate) {
            NSString * strInfo = @"去更新";
            if (!appStoreType) {
                strInfo = @"马上更新";
            }
            [ZXAlertUtils showAAlertMessage:@"有新版本更新!" title:@"提示" buttonText:strInfo buttonAction:^{
                [ZXCommonUtils openApplicationURL:updateURL];
            }];
        }
    }];
}

- (void)updateUserInfo{
    //更新用户信息
    //更新闪屏
    NSString *ageGroup = [[YDAPPManager shareManager] getUserAgeInteger];
    NSString *sex = [[YDAPPManager shareManager] getUserSex];
    [YDUpdateUserInformation httpRequestForFlashScreenWithSexString:sex AgeGroup:ageGroup];
    //更新位置
    AppDelegate * delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [YDUpdateUserInformation httpUpdateMemberPostionWithLocation:delegate.userlocation];
    //更新设备信息
    [YDUpdateUserInformation httpRequestForUpdateEquipmentInfoWithDeviceToken:[[ZXGlobalData shareInstance] deviceToken]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setFd_prefersNavigationBarHidden:true];
    firstCheckEnd = false;
    currentOffsetY = -100;
    startTrackingScroll = true;
    isDecelerating = false;
    [self.navView setBackgroundColor:[UIColor zx_navbarColor]];
    [self.navContentView setBackgroundColor:[UIColor zx_navbarColor]];
    [self.lbTitle setFont:[UIFont zx_titleFontWithSize:zx_navBarTitleFontSize()]];
    self.menuView.clipsToBounds = true;
    [self.menuView setBackgroundColor:[UIColor zx_navbarColor]];
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    
    //初始化菜单状态
    [self initButtonStyle];
    //TableView
    [self.tblDiscoverList setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
    [self.tblDiscoverList setScrollIndicatorInsets:UIEdgeInsetsMake(100, 0, 0, 0)];
    [self.tblDiscoverList setShowsHorizontalScrollIndicator:false];
    [self.tblDiscoverList registerNib:[UINib nibWithNibName:@"HDiscoverCellType1" bundle:nil] forCellReuseIdentifier:HDICOVER_CELLTYPE1];
    [self.tblDiscoverList registerNib:[UINib nibWithNibName:@"HDiscoverCellType2" bundle:nil] forCellReuseIdentifier:HDICOVER_CELLTYPE2];
    [self.tblDiscoverList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tblDiscoverList setBackgroundColor:ZXCLEAR_COLOR];
    _tblDelegate.discoverVC = self;
    
    //下拉刷新
    [self.tblDiscoverList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(refreshAction)];
    [self.tblDiscoverList.mj_header setIgnoredScrollViewContentInsetTop:-5];
    [self.tblDiscoverList.mj_header setHidden:true];
    [self.tblDiscoverList zx_addFooterRefreshActionAutoRefresh:true target:self action:@selector(loadMoreAction)];
    //CollectionView
    [self.collectionViewTools registerNib:[UINib nibWithNibName:@"HDiscoverCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HDICOVER_CC_CELLID];
    [self.collectionViewTools setBackgroundColor:ZXCLEAR_COLOR];
    [self.collectionViewTools setScrollEnabled:false];
    _collectionViewDelegate.discoverVC = self;
    
    currentPage = 1;
    totalPage = 1;
    isLoadingPromotionList = false;
}

//MARK: - 初始化按钮状态
- (void)initButtonStyle{
    [self setNavBarButtonAlpha:0];
    [self hideNavBarButton:true];
}

#pragma mark - 加入会员 二维码扫描
- (IBAction)scanButtonAction:(id)sender {
    [HJoinLeadViewController checkShowWithCompletion:^{
        HQRScanViewController * qrVC = [[HQRScanViewController alloc] init];
        qrVC.needHidNavAfterBack = true;
        qrVC.showRightButton = true;
        [self.navigationController pushViewController:qrVC animated:true];
    }];
}

#pragma mark - 验证会员
- (IBAction)verifyMemberButtonAction:(id)sender {
    HMyQRCodeViewController * myqrcode = [[HMyQRCodeViewController alloc] init];
    [self.navigationController pushViewController:myqrcode animated:true];
}



#pragma mark - 智能工具界面
- (IBAction)smarToolsButtonAction:(id)sender {
    HSmartToolsViewController * smartTools = [[HSmartToolsViewController alloc] init];
    [self.navigationController pushViewController:smartTools animated:true];
}

#pragma mark - Refresh + LoadMore Action
- (void)refreshAction{
    currentPage = 1;
    totalPage = 1;
    [ZXEmptyView dismissInView:_tblDiscoverList];
    [self.tblDiscoverList.mj_footer resetNoMoreData];
    [self loadListDataShowHUD:false];
}

- (void)loadMoreAction{
    currentPage ++;
    [self loadListDataShowHUD:false];
}

- (void)loadListDataShowHUD:(BOOL)bShow{
    if (isLoadingPromotionList) {
        return;
    }
    isLoadingPromotionList = true;
    if (bShow) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXDiscoverViewModel loadDiscoverListByMemberId:[[ZXGlobalData shareInstance] memberId] pageNum:currentPage pageSize:ZXPAGE_SIZE token:[[ZXGlobalData shareInstance] userToken] zxCompletion:^(NSMutableArray<ZXDiscoverModel *> *lists, NSInteger totalPageCount, NSInteger status, BOOL success, NSString *errorMsg) {
        isLoadingPromotionList = false;
        [ZXHUD MBHideForView:self.view animate:true];
        [ZXEmptyView dismissInView:_tblDiscoverList];
        [self.tblDiscoverList.mj_header endRefreshing];
        [self.tblDiscoverList.mj_footer endRefreshing];
        if (!firstCheckEnd) {
            [self zx_checkupdate];
            [self updateUserInfo];
            firstCheckEnd = true;
        }
        if (status == ZXAPI_SUCCESS) {
            totalPage = totalPageCount;
            if (currentPage == 1) {
                arrListModels = [NSMutableArray arrayWithArray:lists];
            }else{
                if (!arrListModels) {
                    arrListModels = [NSMutableArray array];
                }
                [arrListModels addObjectsFromArray:lists];
            }
            if (currentPage >= totalPage) {
                [_tblDiscoverList.mj_footer endRefreshingWithNoMoreData];
            }
            _tblDataSource.lists = arrListModels;
            _tblDelegate.lists = arrListModels;
            [_tblDiscoverList reloadData];
            if (currentPage == 1 && (!arrListModels || arrListModels.count == 0)) {
                [ZXEmptyView showNoDataInView:_tblDiscoverList text1:@"没有新资讯" text2:nil heightFix:-100];
            }
        }else{
            if (status != ZXAPI_LOGIN_INVALID) {
                if (arrListModels) {//之前有数据，再次获取时网络出错
                    if (status == ZXAPI_HTTP_TIME_OUT) {
                        [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:2.0];
                    }else{
                        [ZXHUD MBShowFailureInView:self.view text:@"此时无法访问服务器" delay:2.0];
                    }
                }else{//第一次获取数据就出错 详细网络连接错误
                    if (status == ZXAPI_HTTP_ERROR) {
                        [ZXEmptyView showNetworkErrorInView:_tblDiscoverList heightFix:-100 refreshAction:^{
                            [ZXEmptyView dismissInView:_tblDiscoverList];
                            [self loadListDataShowHUD:true];
                        }];
                    }else{
                        [ZXEmptyView showNoDataInView:_tblDiscoverList text1:@"没有新资讯" text2:nil heightFix:-100];
                        [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
                    }
                }
            }else{
                if ( !arrListModels || arrListModels.count == 0) {
                    [ZXEmptyView showNoDataInView:_tblDiscoverList text1:@"没有新资讯" text2:nil heightFix:-100];
                }
            }
        }
    }];
}

#pragma mark -
- (void)menuActionAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://加入会员 二维码扫描
        {
            [self scanButtonAction:nil];
        }
            break;
        case 1://验证会员
        {
            [self verifyMemberButtonAction:nil];
        }
            break;
            
        case 2://智能工具界面
        {
            [self smarToolsButtonAction:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - ScrollViewDelegate
//开始拖动
- (void)zx_scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    oldOffsetY = scrollView.contentOffset.y;
}
//结束拖动
- (void)zx_scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    newOffsetY = scrollView.contentOffset.y;
    if ((newOffsetY - oldOffsetY) > 0) {
        direction = HScrollUP;
    }else{
        direction = HScrollDOWN;
    }
    if (!decelerate) {//tableView不需要自动回滚
        startTrackingScroll = false;
        [self endDragAcion];
    }else{
        startTrackingScroll = true;
        isDecelerating = true;
    }
}

- (void)zx_scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //自动回滚结束
    [self endDragAcion];
    isDecelerating = false;
}

- (void)zx_scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!startTrackingScroll) {
        //记录offsetY及Direction不做处理
        currentOffsetY = scrollView.contentOffset.y;
        return;
    }
    if (scrollView.contentOffset.y <= -140) {
        [self.tblDiscoverList.mj_header setHidden:false];
    }else{
        [self.tblDiscoverList.mj_header setHidden:true];
    }
    
    CGFloat value = fabs(scrollView.contentOffset.y) / 100;
    value = value >= 1 ? 1 : value;
    value = value <= 0 ? 0 :value;
    
    if (scrollView.contentOffset.y > 0) {
        value = 0;
    }
    
    _menuView.hidden = false;
    _collectionViewTools.alpha = value;
    [self setNavBarButtonAlpha:1 - value];
    _ccTop.constant = - (1 - value) * 50;

    currentOffsetY = scrollView.contentOffset.y;
}

#pragma mark -  显示和隐藏 菜单项动画相关

- (BOOL)isNeedHide{//如果一屏能够放下所有内容 不关闭大工具栏
    if ((self.tblDiscoverList.frame.size.height - self.tblDiscoverList.contentSize.height) >= 100) {
        return false;
    }
    return true;
}

- (void)endDragAcion{
    currentOffsetY = self.tblDiscoverList.contentOffset.y;
    if ([self isNeedHide]) {
        if (direction == HScrollUP) {
            if (currentOffsetY >= -70) {//关闭大菜单 显示小菜的
                if (currentOffsetY < 0) {
                    _ccTop.constant = -50;
                    [UIView animateWithDuration:0.35 animations:^{
                        [_collectionViewTools setAlpha:0];
                        [self setNavBarButtonAlpha:1];
                        [_tblDiscoverList setContentOffset:CGPointMake(0, 0)];
                        [_menuView layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        startTrackingScroll = true;
                        [_menuView setHidden:true];//collection 的父视图
                    }];
                }else{//已经完全关闭了
                    _ccTop.constant = -50;
                    [_menuView setHidden:true];
                    startTrackingScroll = true;
                }
            }else{//显示大菜单 关闭小菜的
                if (currentOffsetY > -100 && currentOffsetY < 0) {
                    _ccTop.constant = 0;
                    [UIView animateWithDuration:0.35 animations:^{
                        [_collectionViewTools setAlpha:1];
                        [self setNavBarButtonAlpha:0];
                        [_tblDiscoverList setContentOffset:CGPointMake(0, -100)];
                        [_menuView layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        startTrackingScroll = true;
                        [self hideNavBarButton:true];
                    }];
                }else{//已经完全显示了
                    _ccTop.constant = 0;
                    [self hideNavBarButton:true];
                    startTrackingScroll = true;
                }
            }
        }else{
            if (currentOffsetY <= -30) {//显示大菜单 关闭小菜的
                if (currentOffsetY > -100 && currentOffsetY < 0) {
                    _ccTop.constant = 0;
                    [UIView animateWithDuration:0.35 animations:^{
                        [_collectionViewTools setAlpha:1];
                        [self setNavBarButtonAlpha:0];
                        [_tblDiscoverList setContentOffset:CGPointMake(0, -100)];
                        [_menuView layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        startTrackingScroll = true;
                        [self hideNavBarButton:true];
                    }];
                }else{//已经完全显示了
                    _ccTop.constant = 0;
                    startTrackingScroll = true;
                    [self hideNavBarButton:true];
                }
            }else{//关闭大菜单 显示小菜的
                if (currentOffsetY < 0) {
                    _ccTop.constant = -50;
                    [UIView animateWithDuration:0.35 animations:^{
                        [_collectionViewTools setAlpha:0];
                        [self setNavBarButtonAlpha:1.0];
                        [_tblDiscoverList setContentOffset:CGPointMake(0, 0)];
                        [_menuView layoutIfNeeded];
                    } completion:^(BOOL finished) {
                        startTrackingScroll = true;
                        [_menuView setHidden:true];//collection 的父视图
                    }];
                }else{//已经完全关闭了
                    _ccTop.constant = -50;
                    startTrackingScroll = true;
                    [_menuView setHidden:true];
                }
            }
        }
    }else{//一个屏幕已经全部显示完了
        if (_collectionViewTools.alpha < 1) {
            _ccTop.constant = 0;
            [UIView animateWithDuration:0.35 animations:^{
                [_collectionViewTools setAlpha:1];
                [self setNavBarButtonAlpha:0];
                [_tblDiscoverList setContentOffset:CGPointMake(0, -100)];
                [_menuView layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self hideNavBarButton:true];
                startTrackingScroll = true;
            }];
        }else{
            startTrackingScroll = true;
        }
    }
}

- (void)hideNavBarButton:(BOOL)hide{
    for (UIButton * button in _navButtons) {
        [button setHidden:hide];
    }
}

- (void)setNavBarButtonAlpha:(CGFloat)alpha{
    if (alpha <= 0) {
        [self hideNavBarButton:true];
        for (UIButton * button in _navButtons) {
            [button setAlpha:alpha];
        }
    }else if (alpha < 1) {
        [self hideNavBarButton:false];
        for (UIButton * button in _navButtons) {
            [button setAlpha:alpha];
        }
    }else{
        [self hideNavBarButton:false];
        for (UIButton * button in _navButtons) {
            [button setAlpha:1];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 粘贴板加入会员检测
- (void)pasteBoardCheck {
    UIPasteboard * pasteBoard = [UIPasteboard generalPasteboard];
    NSString * result = pasteBoard.string;
    NSRange domainRange = [result rangeOfString:ZX_QRCODE_CONTAIN];
    if (domainRange.length) {
        NSRange storeIdRange = [result rangeOfString:@"drugstoreid=[\\d]*" options:NSRegularExpressionSearch range:NSMakeRange(0, result.length)];
        NSRange userIdRange = [result rangeOfString:@"userid=[\\d]*" options:NSRegularExpressionSearch range:NSMakeRange(0, result.length)];
        if (storeIdRange.length > 0) {
            NSString * storeId = [result substringWithRange:storeIdRange];
            storeId = [storeId stringByReplacingOccurrencesOfString:@"drugstoreid=" withString:@""];
            
            long long sId = [storeId longLongValue];
            if (sId < 2000000) {//ID 小于2,000,000
                sId += 2000000;
            }
            
            NSString * userId = nil;
            if (userIdRange.length > 0 ) {
                userId = [result substringWithRange:userIdRange];
                userId = [userId stringByReplacingOccurrencesOfString:@"userid=" withString:@""];
            }
            
            [ZXJoinMemberViewModel isStoreMember:[NSString stringWithFormat:@"%@",@(sId)] memberId:[ZXGlobalData shareInstance].memberId token:[ZXGlobalData shareInstance].userToken completion:^(BOOL isMember, NSString *storeName, BOOL success) {
                if (success) {
                    if (!isMember) {
                        [ZXAlertUtils showAAlertMessage:[NSString stringWithFormat:@"是否加入[%@]会员",storeName] title:@"提示" buttonTexts:@[@"取消",@"加入"] buttonAction:^(int buttonIndex) {
                            if (buttonIndex == 1) {
                                [self joinMemberToStoreId:[NSString stringWithFormat:@"%@",@(sId)] recommendUserId:userId];
                            }
                        }];
                    } else {
                        ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
                        NSMutableArray *ViewCtr = [NSMutableArray arrayWithObject:[self.navigationController.viewControllers firstObject]];
                        [ViewCtr addObject:webStore];
                        [self.navigationController setViewControllers:ViewCtr animated:YES];
                        //[webStore.navigationController setNavigationBarHidden:true animated:true];
                    }
                }
            }];
            
            pasteBoard.string = @"";
            
        }
    }
}

- (void)joinMemberToStoreId:(NSString *)storeId recommendUserId:(NSString *)userId{
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    
    [ZXJoinMemberViewModel joinMemberToStore:storeId
                                    location:_location
                                    memberId:[[ZXGlobalData shareInstance] memberId]
                                      userId:userId
                                       token:[[ZXGlobalData shareInstance] userToken]
                                  completion:^(BOOL isNew, NSInteger status, BOOL success, NSString *errorMsg) {
                                      if (status == ZXAPI_SUCCESS) {
                                          [ZXNotificationCenter postNotificationName:ZXNOTICE_JOINMEMBER_SUCCESS object:@{@"storeId":storeId}];
                                          //获取店铺详情并跳转
                                          [ZXJoinMemberViewModel getDrugStoreDetailsByID:storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken] completion:^(ZXDrugStoreModel *drugStore, NSInteger status, BOOL success, NSString *errorMsg) {
                                              [ZXHUD MBHideForView:self.view animate:true];
                                              if (status == ZXAPI_SUCCESS) {
                                                  if (drugStore) {
                                                      if (isNew) {
                                                          HJoinSuccessViewController * successVC = [[HJoinSuccessViewController alloc] init];
                                                          successVC.storeInfo = drugStore;
                                                          [self.navigationController pushViewController:successVC animated:true];
                                                      }else{
                                                          
                                                          ZXStoreRootViewController * webStore = [ZXStoreRootViewController configVCWith:drugStore.storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
                                                          
                                                          NSMutableArray *ViewCtr = [NSMutableArray arrayWithObject:[self.navigationController.viewControllers firstObject]];
                                                          [ViewCtr addObject:webStore];
                                                          [self.navigationController setViewControllers:ViewCtr animated:YES];
                                                          //[webStore.navigationController setNavigationBarHidden:true animated:true];
                                                      }
                                                  }else{
                                                      [ZXAlertUtils showAAlertMessage:@"店铺不存在或已过期" title:@"提示" buttonText:@"确定" buttonAction:nil];
                                                  }
                                              }else{
                                                  [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
                                                  
                                              }
                                          }];
                                          if (isNew) {
                                              //获取历史未失效现金券 失败不做二次处理
                                              [ZXJoinMemberViewModel getStoreHistoryCashCouponById:storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
                                              //历史促销信息
                                              [ZXJoinMemberViewModel getStoreHistoryPromotionById:storeId memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
                                          }
                                      }else{
                                          [ZXHUD MBHideForView:self.view animate:true];
                                          [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
                                      }
                                  }];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
