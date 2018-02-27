//
//  YDJoinMemberViewController.m
//  ydhyk
//
//  Created by 120v on 2016/10/26.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDJoinMemberViewController.h"
/** cell*/
#import "YDListTableViewCell.h"
/** header*/
#import "YDJoinMemberHeaderView.h"
/** 地图*/
#import "YDNearbyRootViewController.h"
//#import "YDNavigationRootViewController.h"
/** 二维码*/
//#import "YDScanQRViewController.h"

static NSString *const joinCell = @"joinCell";
static NSString *const joinHeaderCell = @"joinHeaderCell";

@interface YDJoinMemberViewController ()<UITableViewDelegate,UITableViewDataSource,YDListTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YDJoinMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    self.navigationItem.title = @"卡.购药";
    self.tableView.backgroundColor = ZXRGB_COLOR(239, 247, 253);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YDListTableViewCell class]) bundle:nil] forCellReuseIdentifier:joinCell];
    [self.tableView registerClass:[YDJoinMemberHeaderView class] forHeaderFooterViewReuseIdentifier:joinHeaderCell];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YDListTableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:joinCell forIndexPath:indexPath];
    listCell.delegate = self;
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return listCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 267;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YDJoinMemberHeaderView *headerView = [[YDJoinMemberHeaderView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 264)];
    
    return headerView;
}

#pragma mark - YDListTableViewCellDelegate
#pragma mark 定位
-(void)didListViewLocationButton:(UIButton *)sender{
    YDNearbyRootViewController *mapVC = [[YDNearbyRootViewController alloc]init];
    
    CLLocationCoordinate2D coor;
    coor.latitude = 33.000;
    coor.longitude = 106.124;
    
    mapVC.locationCoor = coor;
    mapVC.navigationController.navigationBar.hidden = NO;
    
//    YDNavigationRootViewController *nv = [[YDNavigationRootViewController alloc]initWithRootViewController:mapVC];
//    
//    [self.navigationController presentViewController:nv animated:YES completion:nil];
    
}
#pragma mark 电话
-(void)didListViewTelephoneButton:(UIButton *)sender{
    
}
#pragma mark 加入会员
-(void)didListViewJoinMemberButton:(UIButton *)sender{
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        YDScanQRViewController *scanQr = [[YDScanQRViewController alloc]initWithBlock:^(NSString *qrStr) {
//            NSLog(@"%@",qrStr);
//            
//        }];
//        //    scanQr.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:scanQr animated:YES];
//    });
}


@end
