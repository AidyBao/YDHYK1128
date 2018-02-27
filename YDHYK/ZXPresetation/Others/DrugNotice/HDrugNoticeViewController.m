//
//  HDrugNoticeViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/26.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HDrugNoticeViewController.h"
#import "HDrugRemidTableViewCell.h"
#import "HDrugPresetationController.h"
#import "ZXDrugNoticeControlViewModel.h"

@interface HDrugNoticeViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbTipInfo;
@property (weak, nonatomic) IBOutlet UIView *hSeparatorLine;
@property (weak, nonatomic) IBOutlet UITableView *tblRemindList;
@property (weak, nonatomic) IBOutlet UIButton *btnFitNow1;
@property (weak, nonatomic) IBOutlet UIButton *btnFitNow2;
@property (weak, nonatomic) IBOutlet UIButton *btnRemindLater;
@property (weak, nonatomic) IBOutlet UIView *vContent;

@end

@implementation HDrugNoticeViewController

- (instancetype)init{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;

    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:ZXCLEAR_COLOR];
    [_vContent setBackgroundColor:ZXWHITE_COLOR];
    [_vContent.layer setCornerRadius:5];
    [_vContent.layer setMasksToBounds:true];
    [_vContent setClipsToBounds:true];
    
    [_lbTime setFont:[UIFont zx_titleFontWithSize:40.0]];
    [_lbTime setTextColor:[UIColor zx_tintColor]];
    
    [_lbTipInfo setFont:[UIFont zx_titleFontWithSize:13]];
    [_lbTipInfo setTextColor:[UIColor zx_tintColor]];
    
    [_btnFitNow1.layer setMasksToBounds:true];
    [_btnFitNow1.layer setCornerRadius:10.0];
    [_btnFitNow1 setBackgroundColor:ZXWHITE_COLOR];
    [_btnFitNow1 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
    [_btnFitNow1.titleLabel setFont:[UIFont zx_titleFontWithSize:15]];
    
    [_btnFitNow2.layer setMasksToBounds:true];
    [_btnFitNow2.layer setCornerRadius:5];
    [_btnFitNow2 setBackgroundColor:ZXWHITE_COLOR];
    [_btnFitNow2 setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
    [_btnFitNow2.titleLabel setFont:[UIFont zx_titleFontWithSize:15]];
    
    [_btnRemindLater.layer setMasksToBounds:true];
    [_btnRemindLater.layer setCornerRadius:5];
    [_btnRemindLater setBackgroundColor:ZXRGB_COLOR(103, 103, 103)];
    [_btnRemindLater setTitleColor:ZXWHITE_COLOR forState:UIControlStateNormal];
    [_btnRemindLater.titleLabel setFont:[UIFont zx_titleFontWithSize:15]];
    
    [self.tblRemindList setBackgroundColor:ZXCLEAR_COLOR];
    [self.tblRemindList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tblRemindList registerNib:[UINib nibWithNibName:@"HDrugRemidTableViewCell" bundle:nil] forCellReuseIdentifier:@"HDrugRemidTableViewCell"];
    
//    [_btnFitNow2 setHidden:true];
    [_btnFitNow1     setHidden:true];
    [_btnRemindLater setHidden:true];
    [self configButton];
    
    [_lbTime setText:_remindTime];
}

- (void)configButton{
    if ([[[YDAPPManager shareManager] getUserIsRepeatedReminders] isEqualToString:@"0"]) {//0 开 1 关
        [_btnFitNow2     setHidden:true];
        
        [_btnFitNow1     setHidden:false];
        [_btnRemindLater setHidden:false];
    }else{
        [_btnFitNow2     setHidden:false];
        
        [_btnFitNow1     setHidden:true];
        [_btnRemindLater setHidden:true];
    }
}

- (IBAction)fitNow:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)remindLater:(id)sender {
    if (self.list && self.list.count) {
        NSMutableArray * arrIds = [NSMutableArray array];
        [self.list enumerateObjectsUsingBlock:^(ZXTakeMedicineModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrIds addObject:obj.detailId];
        }];
        NSString * detailIds = [arrIds componentsJoinedByString:@","];
        [ZXDrugNoticeControlViewModel remindLaterWithIds:detailIds memberId:[[ZXGlobalData shareInstance] memberId] token:[[ZXGlobalData shareInstance] userToken]];
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_list && _list.count) {
        return _list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HDrugRemidTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HDrugRemidTableViewCell" forIndexPath:indexPath];
    [cell reloadViewDrugModel:_list[indexPath.row]];
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 38;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
//MARK: Present
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[HDrugPresetationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
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
