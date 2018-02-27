//
//  YDLoginRootViewController.m
//  YDHYK
//
//  Created by 120v on 2016/11/29.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDLoginRootViewController.h"
/** 注册*/
#import "YDRegistViewController.h"
/** 闪屏数据模型*/
#import "YDFlashScreenModel.h"
/** 更新用户信息接口*/
#import "YDUpdateUserInformation.h"

#import "ZXWebStoreViewController.h"


//手机号码输入位数最大值
#define H_TELEPHONE_LENTH_MAX 11
#define H_Verification_Code_LENTH_MAX 6
#define Login_Tel_TextField_Tag 1101
#define Login_VerCode_TextField_Tag 1102

@interface YDLoginRootViewController ()<UITextFieldDelegate,YDRegistViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet ZXTintButton *codeButton;
@property (weak, nonatomic) IBOutlet ZXTintButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIView *bigBackView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *loginImgView;

/** 电话号码*/
@property (nonatomic,strong) NSString *telePhoneNum;
/** 验证码*/
@property (nonatomic,strong) NSString *VerCode;
/** 是否为新会员*/
@property (nonatomic,assign) NSInteger isNew;

@property (nonatomic,assign) BOOL isGettingPhoneCode;

@end

@implementation YDLoginRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.fd_prefersNavigationBarHidden = true;
    //新会员初始化
    self.isNew = -1;
    self.isGettingPhoneCode = false;
    
    //初始化
    [self initWithUIStyle];
    
    //touch
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
    [self.bigBackView addGestureRecognizer:tap];
    
    //键盘通知
    [self addKeyBoardObsever];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - 初始化
-(void)initWithUIStyle{
    
    //动画
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 54; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"HYKLog-%d",i]];
        [array addObject:img];
    }
    [self.loginImgView setAnimationImages:array];
    [self.loginImgView setAnimationDuration:2.0];
    [self.loginImgView setAnimationRepeatCount:1];
    [self.loginImgView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loginImgView stopAnimating];
        [self.loginImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"HYKLog-%d",54]]];
    });
    
    
    self.telLabel.textColor = [UIColor zx_textColor];
    self.codeLabel.textColor = [UIColor zx_textColor];
    [self.codeButton setTitleColor:[UIColor zx_tintColor] forState:UIControlStateNormal];
    self.loginButton.enabled = NO;
    [self.loginButton.layer setCornerRadius:5.0];
    [self.loginButton.layer setMasksToBounds:YES];
    
    self.telTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.telTextField setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [self.passwordTextField setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
}

#pragma mark - touch
-(void)touch{
    [self.bigBackView endEditing:YES];
    [self.telTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark - 添加键盘通知
- (void)addKeyBoardObsever{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 键盘出现时调用
- (void)keyboardWillShow:(NSNotification *)notify{
    CGFloat kbHeight = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat viewBottom = CGRectGetMaxY(self.loginButton.frame);
    if (viewBottom + kbHeight < screenHeight) return;
    CGFloat reheight = viewBottom + kbHeight - screenHeight + 1;//键盘和输入框之间留了1个点的空隙
    [self.scrollView setContentOffset:CGPointMake(0, reheight)];
}

#pragma mark 键盘收起时调用
- (void)keyboardWillHidden:(NSNotification *)notify{
    //键盘收起时还原到之前布局
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
}


#pragma mark - UITextFeiledDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == Login_Tel_TextField_Tag) {
        [self.passwordTextField resignFirstResponder];
        [self.telTextField becomeFirstResponder];
    }else if(textField.tag == Login_VerCode_TextField_Tag){
        [self.telTextField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    }
    //处理搜索显示
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == Login_Tel_TextField_Tag) {
        [self.telTextField resignFirstResponder];
    }
    if (textField.tag == Login_VerCode_TextField_Tag) {
        [self.passwordTextField resignFirstResponder];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [self.telTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == Login_Tel_TextField_Tag) {
        if (range.location > 10) {
            [ZXHUD MBShowFailureInView:self.view text:@"手机号不能大于11位！" delay:1.2];
            return NO;
        }
    }
    if (textField.tag == Login_VerCode_TextField_Tag) {
        if (range.location > 5) {
            [ZXHUD MBShowFailureInView:self.view text:@"验证码不能大于6位！" delay:1.2];
            return NO;
        }
    }
    return YES;
}

#pragma mark TextField发生改变时调用
-(void)textFieldDidChange:(NSNotification *)obj{
    //1.取值,并去除空字符
    UITextField *textField = (UITextField *)obj.object;
    NSString *str=textField.text;
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *keyString = [str stringByTrimmingCharactersInSet:set];
    if (textField.tag == Login_Tel_TextField_Tag) {
        if (keyString.length == 0 || (keyString.length && self.passwordTextField.text.length == 0) || (keyString.length == 0 && self.passwordTextField.text.length == 0)) {
            self.loginButton.enabled = NO;
        }else if(keyString.length == H_TELEPHONE_LENTH_MAX && self.passwordTextField.text.length == H_Verification_Code_LENTH_MAX){
            self.loginButton.enabled = YES;
        }else if(keyString.length > H_TELEPHONE_LENTH_MAX){
            return;
        }else{
            self.loginButton.enabled = NO;
        }
    }
    if (textField.tag == Login_VerCode_TextField_Tag) {
        if (keyString.length == 0 || (keyString.length && self.telTextField.text.length == 0) || (keyString.length == 0 && self.telTextField.text.length == 0)) {
            self.loginButton.enabled = NO;
        }else if(keyString.length == H_Verification_Code_LENTH_MAX && self.telTextField.text.length == H_TELEPHONE_LENTH_MAX){
            self.loginButton.enabled = YES;
        }else if(keyString.length > H_Verification_Code_LENTH_MAX){
            return;
        }else{
            self.loginButton.enabled = NO;
        }
    }
}

#pragma mark - 获得验证码
- (IBAction)getCode:(id)sender {
    if (self.telTextField.text.length == 0) {
        [ZXHUD MBShowFailureInView:self.view text:@"手机号不能为空" delay:1.2];
        return;
    }
    AppDelegate *appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.isConnected) {
        //判断用户输入的是否是个电话号码的格式
        if ([ZXStringUtils isMobileValid:self.telTextField.text] == YES) {
            
            //禁用
            if (self.codeButton.enabled == NO) {
                return;
            }
            self.codeButton.enabled = NO;
            
            //保存电话号码
            self.telePhoneNum = self.telTextField.text;
            
            //获取验证码
            [self httpRequestForVerVerificationCode];
            
            //鼠标定位到验证码输入框
            [self.telTextField resignFirstResponder];
            [self.passwordTextField becomeFirstResponder];
            
        }else{
            self.codeButton.enabled = YES;
            [ZXHUD MBShowFailureInView:self.view text:@"请输入正确的手机号" delay:1.2];
        }
    }else{
        self.codeButton.enabled = YES;
        [ZXHUD MBShowFailureInView:self.view text:@"已断开网络" delay:1.2];
    }
}

#pragma mark - 倒计时
-(void)regetcode:(NSNumber *)str{
    //倒计时
    NSInteger time=[str integerValue];
    if (time>1) {
        time-=1;
        [self.codeButton setTitle:[NSString stringWithFormat:@"已发送(%lds)",(long)time] forState:UIControlStateNormal];
        self.codeButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [self performSelector:@selector(regetcode:) withObject:@(time) afterDelay:1];
        self.codeButton.enabled=NO;
        return;
    }
    
    self.codeButton.enabled=YES;
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
}

#pragma mark - HTTP_Request
#pragma mark 登录
- (IBAction)login:(UIButton *)sender {
    [self.view endEditing:YES];
    [self.telTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    //APP公共测试账号
    if ([self.passwordTextField.text isEqualToString:ZXAPP_Common_TestAccount_Password] && [self.telTextField.text isEqualToString:ZXAPP_Common_TestAccount]) {
        [self httpRequestLogin];
    }else{
        //判断前后输入的电话号码是否一致
        if ([self.passwordTextField.text isEqualToString:self.VerCode]) {
            if ([self.telTextField.text isEqualToString:self.telePhoneNum]) {
                //登录请求
                [self httpRequestLogin];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:@"请输入正确的手机号" delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:@"请输入正确的验证码" delay:1.2];
        }
    }
}

#pragma mark 获取验证码
-(void)httpRequestForVerVerificationCode{
    if (self.isGettingPhoneCode) {
        return;
    }
    self.isGettingPhoneCode = true;
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    [dicParams setObject:self.telTextField.text forKey:@"tel"];
    __weak typeof(self) weakSelf = self;
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Get_Verification_Code) params:dicParams token:nil method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        _isGettingPhoneCode = false;
        [ZXHUD MBHideForView:self.view animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {//
                //倒计时开始
                [self performSelector:@selector(regetcode:) withObject:@(60) afterDelay:1];

                weakSelf.VerCode = [NSString stringWithFormat:@"%@",content[@"smsCode"]];
                [ZXHUD MBShowSuccessInView:self.view text:@"验证码发送成功" delay:1.2];
            }else{//
                self.codeButton.enabled=YES;
                [ZXHUD MBShowFailureInView:self.view text:@"验证码发送失败" delay:1.2];
            }
        }else{
            self.codeButton.enabled=YES;
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark 登录请求
-(void)httpRequestLogin{
    //禁用登录按钮
    self.loginButton.enabled = NO;
    
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    
    //此UUID通过保存在KeyChain中，保证了UUID的相对唯一性
    NSString *telePhoneUUID = [ZXCommonUtils getUUID];
    if (telePhoneUUID.length) {
        [dicParams setObject:telePhoneUUID forKey:@"uuid"];
    }
    [dicParams setObject:self.telTextField.text forKey:@"tel"];
   
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Login) params:dicParams token:nil method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        //开启loginButton
        self.loginButton.enabled = YES;
        if (success) {
            if (status == ZXAPI_SUCCESS) {//登录成功
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];
                /*保存用户登录信息*/
                [weakSelf saveLoginUserInfro:(NSDictionary *)content[@"data"]];
                
                /*更新用户个人信息*/
                [weakSelf httpRequestUserInfromation];
                
                /*进入主界面*/
                NSInteger isNew = -1;
                isNew = [content[@"data"][@"isNew"]integerValue];
                weakSelf.isNew = isNew;
                [weakSelf changeControllerInterface:isNew];
                
            }else{//登录失败
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark 保存用户登录信息
-(void)saveLoginUserInfro:(NSDictionary *)dict{
    //储存登录状态
    [[YDAPPManager shareManager] getLoginBaseUser].isLoginSataus = YES;
    [[YDAPPManager shareManager] saveLoginSataus];
    
    /*存登录所有数据*/
    [[YDAPPManager shareManager] setLoginDict:dict];
}

#pragma mark 切换控制器界面
-(void)changeControllerInterface:(NSInteger)isNew{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //1. 登录失效
            if (self.logonFailue == true) {
                
                if ([self.lastLoginID isEqualToString:self.telTextField.text]) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    return;
                }else{//切换账号的情况
                    //清空tabBar
                    [ZXRootViewControllers reload];
                    [ZXRouter changeRootViewController:[ZXRootViewControllers zx_tabbarController]];
                }
            }
            
            //2. 1秒后异步执行这里的代码...
            if (isNew == 1) {//进入修改个人信息页面
                YDRegistViewController *registVC = [[YDRegistViewController alloc]initWithNibName:@"YDRegistViewController" bundle:nil];
                registVC.delegate = self;
                [self.navigationController pushViewController:registVC animated:YES];
            }else if(isNew == 0){//进入主界面
                [ZXRouter changeRootViewController:[ZXRootViewControllers zx_tabbarController]];
            }
        });
}

#pragma mark 上传设备信息/获取闪屏数据/更新个人位置
-(void)httpRequestUserInfromation{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //1.获取设备信息
        NSString *deviceToken = [[ZXGlobalData shareInstance] deviceToken];
        [YDUpdateUserInformation httpRequestForUpdateEquipmentInfoWithDeviceToken:deviceToken];
        
        //2.网络请求闪屏信息并保存
        if (self.isNew == 0) {//不是新会员
            NSString *ageGroup = [[YDAPPManager shareManager] getUserAgeInteger];
            NSString *sex = [[YDAPPManager shareManager] getUserSex];
            [YDUpdateUserInformation httpRequestForFlashScreenWithSexString:sex AgeGroup:ageGroup];
        }
        //3.更新会员位置
        CLLocation *location = ((AppDelegate *)[UIApplication sharedApplication].delegate).userlocation;
        [YDUpdateUserInformation httpUpdateMemberPostionWithLocation:location];
    });
}

#pragma mark - YDRegistViewControllerDelegate
-(void)didSelectedRegistWithSex:(NSString *)sex withAgeGroup:(NSString *)ageGroup{
    //会员首次更新个人信息后,再次获取闪屏数据
    if (self.isNew == 1) {//新会员
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [YDUpdateUserInformation httpRequestForFlashScreenWithSexString:sex AgeGroup:ageGroup];
        });
    }
}

#pragma mark - 用户协议
- (IBAction)userAgreementClick:(id)sender {
    [self.navigationController pushViewController:[ZXWebStoreViewController loadWebStoreURLString:[NSString stringWithFormat:@"%@%@",ZXROOT_STATIC_URL,ZXAPI_LICENSE_AGREEMENT]]  animated:YES];
}

#pragma mark - touchesBegan
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self.telTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
