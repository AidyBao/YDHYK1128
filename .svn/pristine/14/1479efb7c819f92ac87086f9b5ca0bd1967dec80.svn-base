//
//  ZXFullCheckListViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/19.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "ZXFullCheckListViewController.h"
#import "DimmingPresentationController.h"
#import "HItemSelectTableCell.h"

@interface ZXFullCheckListViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblCheckList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkListHeight;//min : 120  max :40 * (5 + 1)

@end

@implementation ZXFullCheckListViewController

+ (void)presentOnVC:(UIViewController *)vc title:(NSString *)title checkList:(NSArray<NSString *> *)checkList completion:(ZXCheckEnd)completion{
    ZXFullCheckListViewController * fullCheckListVC = [[ZXFullCheckListViewController alloc] init];
    fullCheckListVC.checkList = checkList;
    fullCheckListVC.titleName = title;
    fullCheckListVC.checkEnd = completion;
    [vc presentViewController:fullCheckListVC animated:true completion:nil];
}

- (instancetype)init{
    if (self = [super init]) {
        [self setModalPresentationStyle:UIModalPresentationCustom];
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:ZXCLEAR_COLOR];
    [self.maskView setBackgroundColor:ZXCLEAR_COLOR];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(dismissAcion)];
    [self.maskView addGestureRecognizer:tap];
    
    [_lbTitle setFont:[UIFont zx_titleFontWithSize:15.0]];
    [_lbTitle setTextColor:[UIColor zx_textColor]];
    
    [_tblCheckList setSeparatorColor:[UIColor zx_separatorColor]];
    [_tblCheckList registerNib:[UINib nibWithNibName:@"HItemSelectTableCell" bundle:nil] forCellReuseIdentifier:@"HItemSelectTableCell"];
    if (_titleName && _titleName.length) {
        [_lbTitle setText:_titleName];
    }else{
        [_lbTitle setText:@"请选择"];
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSInteger count = 2;
    if (_checkList && _checkList.count) {
        count = _checkList.count;
        if (count <= 5) {
            [self.tblCheckList setScrollEnabled:false];
        }else{
            [self.tblCheckList setScrollEnabled:true];
        }
    }
    if (count <= 2) {
        _checkListHeight.constant = 120;
    }else if( count > 5){
        _checkListHeight.constant = (5 + 1) * 40 + 20;
    }else{
        _checkListHeight.constant = (count + 1) * 40;
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        [self.view layoutIfNeeded];
    }];

}

#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HItemSelectTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HItemSelectTableCell" forIndexPath:indexPath];
    cell.needHighlight = true;
    cell.lbItemName.text = _checkList[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_checkList && _checkList.count) {
        return _checkList.count;
    }
    return 0;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissAcion];
    if (_checkEnd) {
        _checkEnd(indexPath.row,_checkList[indexPath.row]);
    }
}

//MARK: Present
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[DimmingPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (void)dismissAcion{
    [self.view endEditing:true];
    [self dismissViewControllerAnimated:true completion:nil];
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
