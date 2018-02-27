//
//  YDEidtNameViewController.m
//  ydhyk
//
//  Created by Aidy Bao on 2016/11/13.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDEidtNameViewController.h"

@interface YDEidtNameViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) NSString *nameString;
@property (nonatomic,strong) UIBarButtonItem *saveButton;

@end

@implementation YDEidtNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改姓名";
    self.view.backgroundColor = [UIColor zx_assistColor];
   
    [self setupsaveButton];
    
    [self setupTextFieldView];
    
    
}
#pragma mark - 输入框
-(void)setupTextFieldView{
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, ZX_BOUNDS_WIDTH, 50)];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameView];
    
    UITextField *nameText = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, nameView.width - 2*15, 50)];
    self.nameText = nameText;
    nameText.delegate = self;
    nameText.backgroundColor = [UIColor whiteColor];
    [nameText setReturnKeyType:UIReturnKeyDone];
    nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameText.placeholder = @"请输入姓名";
    [nameView addSubview:nameText];
    [self.nameText setTextColor:[UIColor zx_textColor]];
    self.nameText.text = self.name;

}

#pragma mark - 保存
-(void)setupsaveButton{
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]init];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.saveButton = saveButton;
    saveButton.title = @"保存";
    [saveButton setAction:@selector(httpRequestForSave)];
    [saveButton setTarget:self];
    saveButton.enabled = NO;
    [saveButton setTintColor:[UIColor zx_sub1TextColor]];
}

-(void)httpRequestForSave{
    [self.view endEditing:YES];
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *keyString = [self.nameString stringByTrimmingCharactersInSet:set];
    if (keyString.length) {
        if ([self.delegate respondsToSelector:@selector(FeedbackString:)]) {
            [self.delegate FeedbackString:self.nameString];
        }
        [self httpRequestForModifyName];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"输入名字不能为空" delay:1.2];
    }
}

#pragma mark - 修改姓名
-(void)httpRequestForModifyName{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    if (self.nameString) {
        [dicParams setObject:self.nameString forKey:@"name"];
    }
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Modify_Name) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];
                
                //更新保存
                [weakSelf saveUserName];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark 姓名
-(void)saveUserName{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[YDAPPManager shareManager] getLoginBaseUser].name = self.nameText.text;
        [[YDAPPManager shareManager] saveUserName];
    });
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.nameText becomeFirstResponder];
    
    //处理搜索显示
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.nameText resignFirstResponder];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:textField];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 15) {
        [ZXHUD MBShowFailureInView:self.view text:@"姓名不能超过16个字符" delay:1.2];
        return NO;
    }
    
    return YES;
}

-(void)textFieldDidChange:(UITextField *)textField{
    //1.取值,并去除空字符
    NSString *str=textField.text;
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *keyString = [str stringByTrimmingCharactersInSet:set];
    
    if (keyString.length == 0) {
        [self.saveButton setTintColor:[UIColor zx_sub1TextColor]];
        [self.saveButton setEnabled:NO];
    }else{
        
        [self.saveButton setTintColor:[UIColor whiteColor]];
        [self.saveButton setEnabled:YES];
    }
    
    self.nameString = keyString;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameText resignFirstResponder];
    [self.nameText endEditing:YES];
}


#pragma mark - UITextFieled
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
