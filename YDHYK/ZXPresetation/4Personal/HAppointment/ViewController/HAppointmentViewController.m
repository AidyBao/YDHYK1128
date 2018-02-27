//
//  HAppointmentViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HAppointmentViewController.h"

@interface HAppointmentViewController ()

@end

@implementation HAppointmentViewController

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:true];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    [self setTitle:@"预约"];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [ZXEmptyView showNoDataInView:self.view text1:@"您还没有预约数据" text2:nil heightFix:0];
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
