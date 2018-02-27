//
//  HJoinLeadViewController.m
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HJoinLeadViewController.h"

@interface HJoinLeadViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbTitle1;
@property (weak, nonatomic) IBOutlet UILabel *lbSubTitle1;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle2;
@property (weak, nonatomic) IBOutlet UILabel *lbSubTitle2;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle3;
@property (weak, nonatomic) IBOutlet UILabel *lbSubTitle3;

@property (nonatomic,copy) HJoinLeadBlock jBlock;

@end

@implementation HJoinLeadViewController

+ (NSString *)showOnce{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ZXShowOnce"];
}


+ (void)checkShowWithCompletion:(HJoinLeadBlock)completion{
    if([self showOnce]){
        if (completion) {
            completion();
        }
    }else{
        HJoinLeadViewController * joinleadVC = [[HJoinLeadViewController alloc] init];
        joinleadVC.jBlock = completion;
        [[ZXAlertUtils keyController] presentViewController:joinleadVC animated:false completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_lbTitle1 setTextColor:[UIColor zx_tintColor]];
    [_lbTitle1 setFont:[UIFont zx_titleFontWithSize:20]];
    [_lbSubTitle1 setTextColor:[UIColor zx_textColor]];
    [_lbSubTitle1 setFont:[UIFont zx_titleFontWithSize:zx_bodyFontSize()]];
    
    [_lbTitle2 setTextColor:[UIColor zx_colorWithHEXString:@"#49bfec" alpha:1]];
    [_lbTitle2 setFont:[UIFont zx_titleFontWithSize:20]];
    [_lbSubTitle2 setTextColor:[UIColor zx_textColor]];
    [_lbSubTitle2 setFont:[UIFont zx_titleFontWithSize:zx_bodyFontSize()]];
    
    [_lbTitle3 setTextColor:[UIColor zx_colorWithHEXString:@"#61d5b6" alpha:1]];
    [_lbTitle3 setFont:[UIFont zx_titleFontWithSize:20]];
    [_lbSubTitle3 setTextColor:[UIColor zx_textColor]];
    [_lbSubTitle3 setFont:[UIFont zx_titleFontWithSize:zx_bodyFontSize()]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:@"ZXShowOnce" forKey:@"ZXShowOnce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:false completion:^{
        if (_jBlock) {
            _jBlock();
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
