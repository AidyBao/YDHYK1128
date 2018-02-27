//
//  HNewPrescriptionViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/8.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HNewPrescriptionViewController.h"
#import "ZXPrescriptionViewModel.h"

@interface HNewPrescriptionViewController ()<UITextFieldDelegate>
{
    NSString * imagePath;
    BOOL isUploading;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgPrescription;
@property (weak, nonatomic) IBOutlet UITextField *txtRemark;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtfBottomOffset;

@end

@implementation HNewPrescriptionViewController

- (void)dealloc{
    [self zx_removeKeyboardNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"新增处方"];
    self.fd_interactivePopDisabled = true;
    
    isUploading = false;
    
    [self.view setBackgroundColor:[UIColor zx_assistColor]];
    [self zx_addRightBarItemsWithTexts:@[@"保存"] font:nil color:nil];
    [self zx_addLeftBarItemsWithTexts:@[@"取消"] font:nil color:nil];
    
    [_imgPrescription setImage:[UIImage imageNamed:@"test"]];
    
    [_txtRemark setBackgroundColor:ZXWHITE_COLOR];
    [_txtRemark setLeftView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 49)]];
    [_txtRemark setLeftViewMode:UITextFieldViewModeAlways];
    [_txtRemark setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_txtRemark setFont:[UIFont zx_titleFontWithSize:zx_title1FontSize()]];
    [_txtRemark setTextColor:[UIColor zx_textColor]];
    [_txtRemark setDelegate:self];
    
    [self zx_addKeyboardNotification];
    
    if (_image) {
        [_imgPrescription setImage:_image];
    }
}


- (void)zx_keyboardWillHideTimeInteval:(double)dt notice:(NSNotification *)notice{
    _txtfBottomOffset.constant = 0;
    [UIView animateWithDuration:dt animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)zx_keyboardWillChangeFrameBeginRect:(CGRect)beginRect endRect:(CGRect)endRect timeInterval:(double)dt notice:(NSNotification *)notice{
    _txtfBottomOffset.constant = endRect.size.height;
    [UIView animateWithDuration:dt animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)zx_leftBarButtonActionsIndex:(NSInteger)index{
    [self.view endEditing:true];
    [ZXAlertUtils showAAlertMessage:@"放弃保存处方?" title:@"提示" buttonTexts:@[@"放弃",@"继续编辑"] buttonAction:^(int buttonIndex) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
}

- (void)zx_rightBarButtonActionsIndex:(NSInteger)index{
    if (isUploading) {
        return;
    }
    [self.view endEditing:true];
    NSString * strTitle = [self.txtRemark text];
    if ([ZXStringUtils isTextEmpty:strTitle]) {
        [ZXHUD MBShowFailureInView:self.view text:@"请填写文字说明" delay:1.5];
        return;
    }
    isUploading = true;
    [ZXHUD MBShowLoadingInView:self.view text:@"数据上传中..." delay:0];
    if (imagePath && imagePath.length) { //上传图片成功 保存接口失败，不再上传图片
        [ZXPrescriptionViewModel addPrescriptionWithMemberId:[[ZXGlobalData shareInstance] memberId] title:strTitle attachFiles:imagePath token:[[ZXGlobalData shareInstance] userToken] completion:^(BOOL addSuccess, NSInteger status, BOOL success, NSString *errorMsg) {
            isUploading = false;
            [ZXHUD MBHideForView:self.view animate:true];
            if (addSuccess) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ZXUpdatePrescriptionList" object:nil];
                [ZXAlertUtils showAAlertMessage:@"处方添加成功" title:@"提示" buttonText:@"确定" buttonAction:^{
                    [self.navigationController popViewControllerAnimated:true];
                }];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
            }
        }];
    }else{//
        [ZXNetworkEngine uploadImageToResourceURL:ZXIMG_Address(ZXAPI_RESOURCE_URL) images:@[_image] compressQulity:0 filePath:ZXPathChuFang token:[[ZXGlobalData shareInstance] userToken] params:@{@"memberId":[[ZXGlobalData shareInstance] memberId]} zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
            if (status == ZXAPI_SUCCESS) {
                imagePath = content[@"filePath"];
                [ZXPrescriptionViewModel addPrescriptionWithMemberId:[[ZXGlobalData shareInstance] memberId] title:strTitle attachFiles:imagePath token:[[ZXGlobalData shareInstance] userToken] completion:^(BOOL addSuccess, NSInteger status, BOOL success, NSString *errorMsg) {
                    isUploading = false;
                    [ZXHUD MBHideForView:self.view animate:true];
                    if (addSuccess) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"ZXUpdatePrescriptionList" object:nil];
                        [ZXAlertUtils showAAlertMessage:@"处方添加成功" title:@"提示" buttonText:@"确定" buttonAction:^{
                            [self.navigationController popViewControllerAnimated:true];
                        }];
                    }else{
                        [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
                    }
                }];
            }else{
                isUploading = false;
                [ZXHUD MBHideForView:self.view animate:true];
                [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.5];
            }
        }];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:true];
}

#pragma mark - 

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:true];
    return true;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >= 30) {
        return NO;
    }
    return YES;
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
