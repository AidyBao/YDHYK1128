//
//  HSystemMessageViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HSystemMessageViewController.h"
#import "HMessageDetailViewController.h"
#import "HMessgeTableViewCell.h"
#import "ZXMessageViewModel.h"

@interface HSystemMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger currentIndex;
    NSInteger totalPageNum;
    NSMutableArray <ZXMessageSortModel *> * arrMsgList;
    BOOL firstLoad;
}
@property (weak, nonatomic) IBOutlet UITableView *tblMsgList;


@end

@implementation HSystemMessageViewController

- (instancetype)init{
    if (self == [super init]) {
        [self setHidesBottomBarWhenPushed:true];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    firstLoad = true;
    currentIndex = 1;
    totalPageNum = 1;
    
    [self setTitle:@"消息"];
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblMsgList setBackgroundColor:[UIColor zx_assistColor]];
    [self.tblMsgList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tblMsgList registerNib:[UINib nibWithNibName:@"HMessgeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HMessgeTableViewCell"];
    
    self.tblMsgList.estimatedRowHeight = 180;
    self.tblMsgList.rowHeight = UITableViewAutomaticDimension;
    [self.tblMsgList zx_addHeaderRefreshActionUseZXImage:true target:self action:@selector(refreshAction)];
    [self.tblMsgList zx_addFooterRefreshActionAutoRefresh:true target:self action:@selector(loadMoreAction)];
    [self.tblMsgList.mj_header beginRefreshing];
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    if (firstLoad) {
//        firstLoad = false;
//        [self loadMessageListWithHUD:true];
//    }
//    
//}

#pragma mark - Data Request

- (void)refreshAction{
    currentIndex = 1;
    totalPageNum = 1;
    [self.tblMsgList.mj_footer resetNoMoreData];
    [self loadMessageListWithHUD:false];
}

- (void)loadMoreAction{
    currentIndex += 1;
    [self loadMessageListWithHUD:false];
}

- (void)loadMessageListWithHUD:(BOOL)hud{
    if (hud) {
        [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    }
    [ZXMessageViewModel getMessageListWithMemberId:[[ZXGlobalData shareInstance] memberId] pageNum:currentIndex pageSize:ZXPAGE_SIZE token:[[ZXGlobalData shareInstance] userToken] completion:^(NSInteger totalPage, NSArray<ZXMessageSortModel *> *msgList, NSInteger status, BOOL success, NSString *errorMsg) {
        [self.tblMsgList.mj_header endRefreshing];
        [self.tblMsgList.mj_footer endRefreshing];
        [ZXEmptyView dismissInView:self.view];
        if (hud) {
            [ZXHUD MBHideForView:self.view animate:true];
        }
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                totalPageNum = totalPage;
                if (currentIndex == 1) {
                    if (msgList && [msgList count]) {
                        arrMsgList = [msgList mutableCopy];
                    }else{
                        [ZXEmptyView showNoDataInView:self.view text1:@"暂无新消息" text2:nil heightFix:0];
                    }
                }else{
                    if (msgList && [msgList count]) {
                        [arrMsgList addObjectsFromArray:msgList];
                    }
                }
                if (currentIndex >= totalPageNum) {
                    [self.tblMsgList.mj_footer endRefreshingWithNoMoreData];
                }
                [_tblMsgList reloadData];
            }else{
                if (status != ZXAPI_LOGIN_INVALID) {
                    [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:2.0];
                }
            }
        }else{
            if (status == ZXAPI_HTTP_TIME_OUT) {
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:2.0];
            }else{
                [ZXEmptyView showNetworkErrorInView:self.view heightFix:0 refreshAction:^{
                    [ZXEmptyView dismissInView:self.view];
                    [self loadMessageListWithHUD:true];
                }];
            }

        }
    }];
}



#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return arrMsgList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HMessgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HMessgeTableViewCell" forIndexPath:indexPath];
    ZXMessageSortModel * model = [arrMsgList objectAtIndex:indexPath.section];
    [cell isNewMessage:!model.readed];
    cell.lbTitle.text = model.msgDesc;
    cell.lbMessageContent.text = model.title;
    cell.lbTime.text = model.sendDateStr;
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZXMessageSortModel * msgModel = [arrMsgList objectAtIndex:indexPath.section];
    msgModel.isRead = @(1);
    [_tblMsgList reloadData];
    HMessageDetailViewController * msgDetail = [[HMessageDetailViewController alloc] init];
    msgDetail.messageId = msgModel.msgId;
    msgDetail.type = [msgModel.type intValue];
    [self.navigationController pushViewController:msgDetail animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
