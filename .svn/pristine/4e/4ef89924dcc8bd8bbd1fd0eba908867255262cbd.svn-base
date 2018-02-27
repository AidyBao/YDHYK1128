//
//  YDRegistViewController.m
//  ydhyk
//
//  Created by 120v on 2016/10/24.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDRegistViewController.h"
#import "YDAgeGroupModel.h"

#define Regist_FemaleBTN_Tag 1101
#define Regist_MaleBTN_Tag 1102

@interface YDRegistViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
/** 导航栏标题*/
@property (weak, nonatomic) IBOutlet UILabel *navigationTitle;
/** 选择性别*/
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
/** 女头像按钮*/
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
/** 男头像按钮*/
@property (weak, nonatomic) IBOutlet UIButton *manButton;
/** 女按钮*/
@property (weak, nonatomic) IBOutlet UIButton *femaleLabelBtn;
/** 男按钮*/
@property (weak, nonatomic) IBOutlet UIButton *manLabelBtn;
/** 选择年龄*/
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
/** 完成*/
@property (weak, nonatomic) IBOutlet UIButton *registButton;
/** PickerView*/
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
/** 数据源*/
@property (strong,nonatomic) NSArray *dataArray;
/** 性别
 *0代表女
 *1代表男
 */
@property (assign,nonatomic) NSInteger gender;
/** 年龄段:
 *0代表20以下
 *1代表20-30岁
 *2代表30-40岁
 *3代表40-50岁
 *4代表50岁以上
 */
@property (copy,nonatomic) NSString *ageGroup;


@end

@implementation YDRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = true;
    self.navigationItem.title = @"个人资料设置";
    self.registButton.layer.cornerRadius = 8.0;
    self.registButton.layer.masksToBounds = YES;
    self.sexLabel.textColor = [UIColor zx_textColor];
    self.ageLabel.textColor = [UIColor zx_textColor];
    self.registButton.backgroundColor = [UIColor zx_buttonBGNormalColor];
    self.registButton.enabled = NO;
    
    self.gender = -1;
    
    /** 设置导航栏*/
    [self setupNavigationView];
    
    /** 获取年龄段*/
    [self httpRequestForGetAgeGroup];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBarHidden = NO;
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:21.0]}];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 设置导航栏
-(void)setupNavigationView{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backButton;
}

-(void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 性别选择
- (IBAction)selectedSexAction:(UIButton *)sender {
    if (sender.tag == Regist_FemaleBTN_Tag) {
        if (sender.selected == NO) {//如果为未选中状态，则选中
            //改变女性头像颜色
            self.femaleButton.selected = !sender.selected;
            self.femaleLabelBtn.selected = sender.selected;
            //改变男性头像颜色
            self.manButton.selected = !sender.selected;
            self.manLabelBtn.selected = !sender.selected;
            //打开“完成”按钮点击事件
            self.registButton.enabled = YES;
            self.registButton.backgroundColor = [UIColor zx_buttonBGNormalColor];
            
            self.gender = 0;

        }else{//如果为选中状态，则取消选中
            self.femaleButton.selected = !sender.selected;
            self.femaleLabelBtn.selected = sender.selected;
            //关闭“完成”按钮点击事件
            self.registButton.enabled = NO;
            self.registButton.backgroundColor = [UIColor zx_buttonBGDisabledColor];
        }
    }
    if (sender.tag == Regist_MaleBTN_Tag) {
        if (sender.selected == NO) {//如果为未选中状态，则选中
           //改变男性头像颜色
            self.manButton.selected = !sender.selected;
            self.manLabelBtn.selected = sender.selected;
            //改变女性头像颜色
            self.femaleButton.selected = !sender.selected;
            self.femaleLabelBtn.selected = !sender.selected;
            //打开“完成”按钮点击事件
            self.registButton.enabled = YES;
            self.registButton.backgroundColor = [UIColor zx_buttonBGNormalColor];
            
            self.gender = 1;
        }else{//如果为选中状态，则取消选中
            self.manButton.selected = !sender.selected;
            self.manLabelBtn.selected = sender.selected;
            //关闭“完成”按钮点击事件
            self.registButton.enabled = NO;
            self.registButton.backgroundColor = [UIColor zx_buttonBGDisabledColor];
        }
    }
}

#pragma mark - 完成
- (IBAction)regist:(UIButton *)sender {
    
//    if (self.ageGroup == 0) {
//        [ZXHUD showFailureWithinText:@"请选择年龄段"];
//        return;
//    }
    
    //回调
    if ([self.delegate respondsToSelector:@selector(didSelectedRegistWithSex:withAgeGroup:)]) {
        [self.delegate didSelectedRegistWithSex:[NSString stringWithFormat:@"%zd",self.gender]  withAgeGroup:[NSString stringWithFormat:@"%zd",self.ageGroup]];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *ageTemp = nil;
        if (self.gender == 0) {
            ageTemp = @"女";
        }else if(self.gender == 1){
            ageTemp = @"男";
        }
        
        //保存性别
        [[YDAPPManager shareManager] getLoginBaseUser].sex = [NSString stringWithFormat:@"%zd",self.gender];
        [[YDAPPManager shareManager] saveUserSex];
        
        [[YDAPPManager shareManager] getLoginBaseUser].sexStr = [NSString stringWithFormat:@"%@",ageTemp];
        [[YDAPPManager shareManager] saveUserSexStr];
        
        //保存年龄段
        [[YDAPPManager shareManager] getLoginBaseUser].ageGroups = self.ageGroup;
        [[YDAPPManager shareManager] saveUserAgeGroup];
        
        //更新性别
        [self httpRequestForUpdateSex];
        //更新年龄段
        [self httpRequestForUpdateAgeGroups];
    });

    dispatch_async(dispatch_get_main_queue(), ^{
        //切换主控制器场景
        [ZXRouter changeRootViewController:[ZXRootViewControllers zx_tabbarController]];
    });
}

#pragma mark - 网络请求
#pragma mark 获取年龄段
-(void)httpRequestForGetAgeGroup{
    NSMutableDictionary * dicParas =[NSMutableDictionary dictionary];
    [dicParas setObject:@"1" forKey:@"type"];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParas setObject:memberID forKey:@"memberId"];
    }
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Get_AgeGroup) params:dicParas token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {//
                id obj = content[@"data"];
                if ([obj isKindOfClass:[NSArray class]]) {
                    //模型转换
                    weakSelf.dataArray = [YDAgeGroupModel mj_objectArrayWithKeyValuesArray:content[@"data"]];
                    
                    //保存服务器返回年龄段
                    [weakSelf saveAgeGroupArray];
                }

            }else{//
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
            //刷新，默认选中
            [weakSelf.pickerView reloadAllComponents];
            [weakSelf.pickerView selectRow:2 inComponent:0 animated:YES];
            //设置默认年龄段为30-40岁
            weakSelf.ageGroup = [NSString stringWithFormat:@"%zd",2];
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark 更新性别
-(void)httpRequestForUpdateSex{
    NSMutableDictionary * dicParas =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    if (memberID) {
        [dicParas setObject:memberID forKey:@"memberId"];
    }
    [dicParas setObject:[NSString stringWithFormat:@"%zd",self.gender] forKey:@"sex"];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Update_Sex) params:dicParas token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {//
//                [ZXHUD showSuccessWithinText:content[@"msg"]];
            }else{//
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark 更新年龄段
-(void)httpRequestForUpdateAgeGroups{
    NSMutableDictionary * dicParas =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    if (memberID) {
        [dicParas setObject:memberID forKey:@"memberId"];
    }
    if (self.ageGroup) {
        [dicParas setObject:self.ageGroup forKey:@"ageGroups"];
    }
    
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Update_AgrGroups) params:dicParas token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {//
                
            }else{//
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}


#pragma mark - 保存服务器返回年龄段
-(void)saveAgeGroupArray{
    NSMutableArray *ageGroupArray = [NSMutableArray array];
    for (YDAgeGroupModel *model in self.dataArray) {
        [ageGroupArray addObject:model.value];
    }
    [[YDAPPManager shareManager] saveAgeGroupArray:ageGroupArray];
}

#pragma mark - UIPickerViewDetaSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 34;
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    YDAgeGroupModel *model = [self.dataArray objectAtIndex:row];
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc]init];
    }
    label.text = [NSString stringWithFormat:@"%@",model.value];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:21.0];
    label.textColor = [UIColor blackColor];
    NSInteger selectedRow = [self.pickerView selectedRowInComponent:component];
    if (component == 0 && selectedRow == row) {
        label.textColor = [UIColor zx_tintColor];
        label.font = [UIFont systemFontOfSize:23.0];
    }
    return label;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    UILabel *lable =(UILabel *) [pickerView viewForRow:row forComponent:component];
    lable.textColor = [UIColor zx_tintColor];
    lable.font = [UIFont systemFontOfSize:23.0];
   
    YDAgeGroupModel *model = [self.dataArray objectAtIndex:row];
    if ([model.value isEqualToString:UNDERTWENTY]) {
        self.ageGroup = [NSString stringWithFormat:@"%zd",0];
    }
    if ([model.value isEqualToString:TWENTY_THIRTY]) {
        self.ageGroup = [NSString stringWithFormat:@"%zd",1];
    }
    if ([model.value isEqualToString:THIRTY_FORTY]) {
        self.ageGroup = [NSString stringWithFormat:@"%zd",2];
    }
    if ([model.value isEqualToString:FORTY_FIFTY]) {
        self.ageGroup = [NSString stringWithFormat:@"%zd",3];
    }
    if ([model.value isEqualToString:ODERFIFTY]) {
        self.ageGroup = [NSString stringWithFormat:@"%zd",4];
    }
}


#pragma mark - lazy
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}


- (IBAction)disMiss:(UIButton *)sender {
    if (self.navigationController.viewControllers.count>0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}


#pragma mark -隐藏Status Bar
-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
