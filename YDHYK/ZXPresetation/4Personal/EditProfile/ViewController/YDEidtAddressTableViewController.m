//
//  YDEidtAddressTableViewController.m
//  ydhyk
//
//  Created by 120v on 2016/11/14.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDEidtAddressTableViewController.h"
/** 自定义TextView*/
#import "BTextView.h"
/** 城市选择器*/
#import "YDAllAddressView.h"

#define EidtAdd_NameTextField_Tag 5121
#define EidtAdd_TelTextField_Tag 5122

@interface YDEidtAddressTableViewController ()<UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>

/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *address;

/** 详情*/
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet BTextView *addressTextView;

/** 保存*/
@property (nonatomic,strong) UIButton *saveButton;
/** 城市选择器*/
@property (nonatomic,strong) YDAllAddressView *addressView;
/** 上传地址*/
@property (nonatomic,strong) NSString *cityAddress;


@end

@implementation YDEidtAddressTableViewController

+(instancetype)instantiateFromStoryboard{
    return [[UIStoryboard storyboardWithName:@"EditProfile" bundle:nil] instantiateViewControllerWithIdentifier:@"YDEidtAddressTableViewController"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isNewAdd == TRUE) {
        self.navigationItem.title = @"添加地址";
    }else if(self.isNewAdd == FALSE){
        self.navigationItem.title = @"编辑地址";
    }
    
    //样式
    [self setupUIStyle];
    
    //导航栏
    [self setupNavgationView];
    
    //赋值
    [self setDefultData];
}

#pragma mark - 样式
-(void)setupUIStyle{
    self.view.backgroundColor = [UIColor zx_assistColor];
    self.tableView.backgroundColor = [UIColor zx_assistColor];
    //标题
    self.name.textColor = [UIColor zx_textColor];
    self.tel.textColor = [UIColor zx_textColor];
    self.address.textColor = [UIColor zx_textColor];
    
    //详情
    self.nameTextField.textColor = [UIColor zx_sub2TextColor];
    self.telTextField.textColor = [UIColor zx_sub2TextColor];
    self.areaLabel.textColor = [UIColor zx_sub2TextColor];
    self.addressTextView.textColor = [UIColor zx_textColor];
    self.addressTextView.placeholder = @"请填写详细地址";
    self.addressTextView.placeholderColor = [UIColor zx_sub2TextColor];
    
    //tableView
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    //手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touch)];
//    [self.view addGestureRecognizer:tap];
}

#pragma mark - 手势
-(void)touch{
    [self.view endEditing:YES];
    [self.nameTextField resignFirstResponder];
    [self.telTextField resignFirstResponder];
    [self.addressTextView resignFirstResponder];
}

#pragma mark - 保存
-(void)setupNavgationView{
    //保存
    self.saveButton = [[UIButton alloc]init];
    self.saveButton.size = CGSizeMake(40, 40);
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton setTitleColor:ZXRGB_COLOR(112, 172, 254) forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.saveButton];
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpace.width = -7;
    self.navigationItem.rightBarButtonItems = @[rightSpace,rightItem];
    self.saveButton.enabled = NO;
}

-(void)saveButtonClick:(UIButton *)sender{
    [self.telTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.addressTextView resignFirstResponder];
    if (self.isNewAdd == TRUE) {
        [self httpRequestForAddReceiverAddress];
    }else{
        [self httpRequestForUpdateReceiverAddress];
    }
}

#pragma mark - 赋值
-(void)setDefultData{
    if (self.addressModel) {
        self.nameTextField.text = self.addressModel.consignee;
        self.telTextField.text = self.addressModel.tel;
        NSArray *aArray = [self.addressModel.cityAddress componentsSeparatedByString:@"-"];
        NSString *newStr = [aArray componentsJoinedByString:@""];
        self.areaLabel.text = newStr;
        self.addressTextView.text = self.addressModel.detailAddress;
        self.cityAddress= self.addressModel.cityAddress;
    }else{
//        self.nameTextField.text = @"";
//        self.telTextField.text = @"";
//        self.areaLabel.text = @"";
//        self.addressTextView.text = @"";
        
    }
}

#pragma mark - HTTP
#pragma mark 新增收货地址
-(void)httpRequestForAddReceiverAddress{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    
    if (self.nameTextField.text.length) {
        [dicParams setObject:self.nameTextField.text forKey:@"consignee"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"姓名不能为空" delay:1.2];
        return;
    }
    if (self.telTextField.text.length) {
        if ([ZXStringUtils isMobileValid:self.telTextField.text] == YES) {
            [dicParams setObject:self.telTextField.text forKey:@"tel"];
        }else{
            [ZXHUD MBShowFailureInView:self.view text:@"请输入正确的手机号" delay:1.2];
            return;
        }
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"手机号不能为空" delay:1.2];
        return;
    }
    
    if (self.cityAddress.length) {
        [dicParams setObject:self.cityAddress forKey:@"cityAddress"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"所在地区不能为空" delay:1.2];
        return;
    }
    
    if (self.addressTextView.text.length) {
        [dicParams setObject:self.addressTextView.text forKey:@"detailAddress"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"详细地址不能为空" delay:1.2];
        return;
    }
    
    if (memberID.length == 0 || token.length == 0) {
        [ZXHUD MBShowFailureInView:self.view text:@"请重新登录" delay:1.2];
        return;
    }else{
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    
    [ZXHUD MBShowLoadingInView:[ZXRootViewControllers window] text:ZX_LOADING_TEXT delay:0.5];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Add_Receiver_Address) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:[ZXRootViewControllers window] animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:0.5];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:0.5];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:0.5];
        }
    }];
}

#pragma mark 编辑收货地址
-(void)httpRequestForUpdateReceiverAddress{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *UID = self.addressModel.uid;
    NSString *consignee = self.nameTextField.text;
    NSString *tel = self.telTextField.text;
    NSString *area = self.cityAddress;
    NSString *detailAddr = self.addressTextView.text;
    NSString *isDefault = self.addressModel.isDefault;
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    
    if (UID.length) {
        [dicParams setObject:UID forKey:@"id"];
    }
    
    if (consignee.length) {
        [dicParams setObject:consignee forKey:@"consignee"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"姓名不能为空" delay:1.2];
        return;
    }
    
    if (tel.length) {
        if ([ZXStringUtils isMobileValid:tel]) {
            [dicParams setObject:tel forKey:@"tel"];
        }else{
            [ZXHUD MBShowFailureInView:self.view text:@"请输入正确的手机号" delay:1.2];
            return;
        }
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"手机号不能为空" delay:1.2];
        return;
    }
    
    if (area.length) {
        [dicParams setObject:area forKey:@"cityAddress"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"所在地区不能为空" delay:1.2];
        return;
    }
    
    if (detailAddr.length) {
        [dicParams setObject:detailAddr forKey:@"detailAddress"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"详细地址不能为空" delay:1.2];
        return;
    }
    
    if (isDefault.integerValue == 0 || isDefault.integerValue == 1) {
        [dicParams setObject:isDefault forKey:@"isDefault"];
    }

    [ZXHUD MBShowLoadingInView:[ZXRootViewControllers window] text:ZX_LOADING_TEXT delay:0.5];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Update_Receiver_Address) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:[ZXRootViewControllers window] animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:0.5];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:0.5];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:0.5];
        }
    }];
}

#pragma mark 删除地址
-(void)httpRequestForDeleteReceiverAddress{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *UID = self.addressModel.uid;
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    if (UID.length) {
        [dicParams setObject:UID forKey:@"id"];
    }
    
    [ZXHUD MBShowLoadingInView:[ZXRootViewControllers window] text:ZX_LOADING_TEXT delay:0.5];
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Delete_Receiver_Address) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:[ZXRootViewControllers window] animate:TRUE];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:0.5];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:0.5];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:0.5];
        }
    }];
}


#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHeight = 0.f;
    if (self.isNewAdd == true) {
        if (indexPath.section == 1) {
            cellHeight = 0;
        }else if (indexPath.section == 0 && indexPath.row == 3){
            cellHeight = 81;
        }else{
            cellHeight = 50;
        }
    }
    if (self.isNewAdd == false) {
        if (indexPath.section == 0 && indexPath.row == 3){
            cellHeight = 81;
        }else{
            cellHeight = 50;
        }
    }
    return cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0://姓名
                [self.telTextField resignFirstResponder];
                [self.addressTextView resignFirstResponder];
                [self.nameTextField isFirstResponder];
                break;
            case 1://电话
                [self.nameTextField resignFirstResponder];
                [self.addressTextView resignFirstResponder];
                [self.telTextField isFirstResponder];
                break;
            case 2://所在地区
            {
                [self.telTextField resignFirstResponder];
                [self.nameTextField resignFirstResponder];
                [self.addressTextView resignFirstResponder];
                
                [self.addressView removeFromSuperview];
                _addressView = nil;
                
                [self.addressView show];
                self.addressView.defaultAddress = self.addressModel.cityAddress;
                __weak typeof(self) weakSelf = self;
                self.addressView.selectBlock = ^(NSString *proviceStr,NSString *cityStr,NSString *disStr){
                    
                    NSString *areaStr = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,disStr];
                    weakSelf.cityAddress = [NSString stringWithFormat:@"%@-%@-%@",proviceStr,cityStr,disStr];
                    if (areaStr.length) {
                        weakSelf.areaLabel.text = areaStr;
                        weakSelf.saveButton.enabled = YES;
                        [weakSelf.saveButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
                    }else{
                        weakSelf.saveButton.enabled = NO;
                        [weakSelf.saveButton setTitleColor:ZXRGB_COLOR(112, 172, 254)forState:UIControlStateNormal];
                    }
                };

            }
                break;
            case 3://详细地址
                [self.telTextField resignFirstResponder];
                [self.nameTextField resignFirstResponder];
                [self.addressTextView isFirstResponder];
                
                break;
                
            default:
                [self.view endEditing:YES];
                break;
        }

    }
    
    if (indexPath.section == 1){//删除地址
        if (indexPath.row == 0) {
            [self httpRequestForDeleteReceiverAddress];
        }else{
            [self.view endEditing:YES];
        }
    }
}

#pragma mark - UITextFeiledDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.addressTextView resignFirstResponder];
    if (textField.tag == EidtAdd_NameTextField_Tag) {
        [self.telTextField resignFirstResponder];
        [self.nameTextField becomeFirstResponder];
    }else if(textField.tag == EidtAdd_TelTextField_Tag){
        [self.nameTextField resignFirstResponder];
        [self.telTextField becomeFirstResponder];
    }
    //处理搜索显示
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == EidtAdd_NameTextField_Tag) {
        [self.nameTextField resignFirstResponder];
    }
    if (textField.tag == EidtAdd_TelTextField_Tag) {
        [self.telTextField resignFirstResponder];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:textField];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameTextField resignFirstResponder];
    [self.telTextField resignFirstResponder];
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (textField.tag == EidtAdd_NameTextField_Tag) {
        if (existedLength - selectedLength + replaceLength > 15) {
            [ZXHUD MBShowFailureInView:self.view text:@"姓名不能超过16个字符" delay:1.2];
            return NO;
        }
    }
    
    if (textField.tag == EidtAdd_TelTextField_Tag) {
        if (range.location > 10) {
            [ZXHUD MBShowFailureInView:self.view text:@"请输入正确的手机号" delay:1.2];
            return NO;
        }
    }

    return YES;
}

#pragma mark TextField发生改变是调用
-(void)textFieldDidChange:(UITextField *)textField{
    //1.取值,并去除空字符
    NSString *str=textField.text;
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *keyString = [str stringByTrimmingCharactersInSet:set];
    if (textField.tag == 5121) {
        if (keyString.length && [keyString isEqualToString:self.addressModel.consignee] == NO) {
            self.saveButton.enabled = YES;
            [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        }else{
            self.saveButton.enabled = NO;
            [self.saveButton setTitleColor:ZXRGB_COLOR(112, 172, 254)forState:UIControlStateNormal];
        }
    }
    if (textField.tag == 5122) {
        if (keyString.length && [keyString isEqualToString:self.addressModel.tel] == NO) {
            if (keyString.length > 11) {
                [ZXHUD MBShowFailureInView:self.view text:@"请输入正确的手机号" delay:1.2];
            }else{
                self.saveButton.enabled = YES;
                [self.saveButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
            }
        }else{
            self.saveButton.enabled = NO;
            [self.saveButton setTitleColor:ZXRGB_COLOR(112, 172, 254)forState:UIControlStateNormal];
        }
    }
}

#pragma mark - UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self.nameTextField resignFirstResponder];
    [self.telTextField resignFirstResponder];
    [self.addressTextView becomeFirstResponder];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [self.addressTextView resignFirstResponder];
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [self.addressTextView resignFirstResponder];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    if (range.location > 0 || text.length >0) {
        self.saveButton.enabled = YES;
        [self.saveButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        if (range.location > 127) {
            [ZXHUD MBShowFailureInView:self.view text:@"姓名不能超过128个字符" delay:1.2];
            return NO;
        }
    }else{
        self.saveButton.enabled = NO;
        [self.saveButton setTitleColor:ZXRGB_COLOR(112, 172, 254)forState:UIControlStateNormal];
    }
    return YES;
}

#pragma mark -Lazy
-(YDAllAddressView *)addressView{
    if (!_addressView) {
        _addressView = [[YDAllAddressView alloc]init];
    }
    return _addressView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
