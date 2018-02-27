//
//  HSmartToolsViewController.m
//  YDHYK
//
//  Created by JuanFelix on 02/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HSmartToolsViewController.h"
#import "HReportAnalyseRootViewController.h"
#import "HSmartToolsCell.h"
#import "YDDrugRemindViewController.h"
#import "HNewReportRecordViewController.h"

@interface HSmartToolsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isPush;
}
@property (weak, nonatomic) IBOutlet UITableView *tblList;

@end

@implementation HSmartToolsViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:true];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    isPush = false;
    [self.navigationController setNavigationBarHidden:false animated:true];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (!isPush) {
        [self.navigationController setNavigationBarHidden:true animated:true];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor zx_navbarColor]];
    [self.tblList setBackgroundColor:ZXCLEAR_COLOR];
    [self.tblList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tblList registerNib:[UINib nibWithNibName:@"HSmartToolsCell" bundle:nil] forCellReuseIdentifier:@"HSmartToolsCell"];
    [self.tblList setScrollEnabled:false];
    [self setTitle:@"智能工具"];
}

#pragma mark - Tableview DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HSmartToolsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HSmartToolsCell" forIndexPath:indexPath];
    [cell loadDataByIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

#pragma mark - Tableview Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    isPush = true;
    if (indexPath.row == 0){//用药提醒
        YDDrugRemindViewController *drug = [YDDrugRemindViewController instantiateFromStoryboard];
        [self.navigationController pushViewController:drug animated:YES];
    }else if (indexPath.row == 1) {//化验单分析
        /*
        //暂无图片分析
        HReportAnalyseRootViewController * reportAnalyse = [[HReportAnalyseRootViewController alloc] init];
        [self.navigationController pushViewController:reportAnalyse animated:true];
        */
        
        HNewReportRecordViewController * addCheckItem = [[HNewReportRecordViewController alloc] init];
        [self.navigationController pushViewController:addCheckItem animated:true];
    }
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
