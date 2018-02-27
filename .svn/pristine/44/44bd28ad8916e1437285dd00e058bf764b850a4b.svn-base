//
//  YDDrugRemindViewController.m
//  ydhyk
//
//  Created by screson on 2016/10/27.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDDrugRemindAddViewController.h"
#import "YDHistoryDrugController.h"
#import "YDDrugRemindViewController.h"
#import "ZXDateView.h"
/** 药品单位以及用药周期弹出框*/
#import "YDPopoverView.h"
/** 用药时间*/
#import "YDSettingDrugTimeView.h"
/** 用药时间模型*/
#import "YDAddDrugTimeModel.h"
/** 历史订单模型*/
#import "YDHistoryOrderModel.h"

#define AddRemind_NameTextField_Tag 5311
#define AddRemind_DosageTextField_Tag 5312
#define AddRemind_NoteTextField_Tag 5313

@interface YDDrugRemindAddViewController ()<YDPopoverViewDelegate,YDHistoryDrugControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBackView;

/** 保存*/
@property (nonatomic,strong) UIButton *saveButton;
/** 药品历史订单按钮*/
@property (weak, nonatomic) IBOutlet UIButton *getHistoryBtn;
/** 药品名称*/
@property (weak, nonatomic) IBOutlet UITextField *drugNameTextField;
/** 每次用量*/
@property (weak, nonatomic) IBOutlet UITextField *dosageTextField;
/** 备注*/
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
/** 用药提醒*/
@property (weak, nonatomic) IBOutlet UILabel *drugRemind;
/** 用药单位*/
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;


/** 高度约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMinBackViewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *header1H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *header2H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cell1H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cell2H;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cell3H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cell4H;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBagBackViewH;


/* 用药单位弹出框*/
@property (nonatomic,strong) YDPopoverView *durgUnitsView;
/* 用药周期弹出框*/
@property (nonatomic,strong) YDPopoverView *durgCycleView;

/* 历史订单*/
@property (nonatomic,strong) NSMutableArray *histOrderArray;
/* 用药时间*/
@property (weak, nonatomic) IBOutlet YDSettingDrugTimeView *drugTimeView;
/* 用药单位*/
@property (nonatomic,copy) NSString *medicineUnit;
/* 用药时间*/
@property (nonatomic,copy) NSString *remindTimes;
/* 用药周期的键*/
@property (nonatomic,copy) NSString *cycleKey;
/* 用量单位*/
//@property (nonatomic,copy) NSString *dosageStr;

@end

@implementation YDDrugRemindAddViewController

+(instancetype)instantiateFromStoryboard{
    return [[UIStoryboard storyboardWithName:@"DrugRemind" bundle:nil] instantiateViewControllerWithIdentifier:@"YDDrugRemindAddViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加提醒";
    //
    [self initWithUIStyle];
    
    //用药提醒历史订单药品列表
    [self httpRequestForGetHistoryDrugOrder];
    
    //导航栏
    [self setupNavgationView];
    
    //获得用药时间
    [self getSettingDrugTime];
}

-(void)initWithUIStyle{
    if ([UIDevice zx_deviceSizeType] == ZX_IPHONE5) {
        self.header1H.constant = 40.f;
        self.header2H.constant = self.header1H.constant;
        self.cell1H.constant = self.cell2H.constant = self.cell3H.constant = self.cell4H.constant = 45.f;
        self.topMinBackViewH.constant = 178.f;
        self.topBagBackViewH.constant = 320.f;
    }else{
        self.header1H.constant = self.header2H.constant = 44.f;
        self.cell1H.constant = self.cell2H.constant = self.cell3H.constant = self.cell4H.constant = 50.f;
        self.topMinBackViewH.constant = 197.f;
        self.topBagBackViewH.constant = 350.f;
    }
    
    [self.drugNameTextField setTextColor:[UIColor zx_textColor]];
    [self.dosageTextField setTextColor:[UIColor zx_textColor]];
    [self.noteTextField setTextColor:[UIColor zx_textColor]];
}

#pragma mark - 保存
-(void)setupNavgationView{
    //保存
    self.saveButton = [[UIButton alloc]init];
    self.saveButton.size = CGSizeMake(40, 40);
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.saveButton];
    UIBarButtonItem *rightSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    rightSpace.width = -7;
    self.navigationItem.rightBarButtonItems = @[rightSpace,rightItem];
    self.saveButton.enabled = YES;
}

-(void)saveButtonClick:(UIButton *)sender{
    [self resignTextFieldFirstResponder];
    //请求
    [self httpRequestForAddTakeMedicineRemind];
}

#pragma mark - 获得设置用药时间
-(void)getSettingDrugTime{
    __weak typeof(self) weakSelf = self;
    self.drugTimeView.setDrugTimeBlock = ^(NSMutableArray *drugTimeArray){
        NSString *remindTimes = [[NSString alloc]init];
        for (int i = 0;i < drugTimeArray.count;i ++) {
            YDAddDrugTimeModel *model = drugTimeArray[i];
            NSString *timeStr = model.drugTime;
            if (drugTimeArray.count == 1) {
                remindTimes = [NSString stringWithFormat:@"%@",timeStr];
            }else{
                if (i == 0) {
                    remindTimes = [NSString stringWithFormat:@"%@",timeStr];
                }else{
                    remindTimes = [NSString stringWithFormat:@"%@,%@",remindTimes,timeStr];
                }
            }
        }
        weakSelf.remindTimes = remindTimes;
    };
}

#pragma mark - 药品名称选择
- (IBAction)drugNameSelectBtn:(id)sender {
    
    [self resignTextFieldFirstResponder];
    
    YDHistoryDrugController *hisVC = [YDHistoryDrugController instantiateFromStoryboard];
    hisVC.delegate = self;
    hisVC.hidesBottomBarWhenPushed = YES;
    hisVC.histOrderArray = self.histOrderArray;
    [self.navigationController pushViewController:hisVC animated:YES];
}

#pragma mark - 每次用量单位选择
- (IBAction)unitsSelectBtn:(id)sender {
    
    [self resignTextFieldFirstResponder];
    
    [self.durgUnitsView removeFromSuperview];
    _durgUnitsView = nil;
    
    [self.durgUnitsView show];
    self.durgUnitsView.type =[NSString stringWithFormat:@"%d",DrugUnitsType];
}

#pragma mark - 用药周期
- (IBAction)drugCycleTime:(id)sender {
    
    [self resignTextFieldFirstResponder];
    
    [self.durgCycleView removeFromSuperview];
    _durgCycleView = nil;
    
    [self.durgCycleView show];
    self.durgCycleView.type =[NSString stringWithFormat:@"%d",DrugTimeType];
}

#pragma mark - YDSixAgeViewDelegate(每次用量/用药周期)
-(void)didPopoverViewWithKey:(NSString *)key andWithValue:(NSString *)value WithTag:(NSInteger)tag{
    [self.view endEditing:YES];
    switch (tag) {
        case DrugUnitsTag:{//每次用量
            if (self.dosageTextField.text.length == 0 || self.dosageTextField.text == nil) {
                [ZXHUD MBShowFailureInView:self.view text:@"每次用量不能为空" delay:1.2];
            }else{
                self.unitLabel.text = value;
                self.medicineUnit = value;
//                self.dosageTextField.text =[NSString stringWithFormat:@"%@",self.medicineUnit];
            }
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.durgUnitsView removeFromSuperview];
                _durgUnitsView = nil;
            });
        }
            break;
        case DrugTimeTag:{//用药周期
            self.drugRemind.text = value;
            self.cycleKey = key;
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.durgCycleView removeFromSuperview];
                _durgCycleView = nil;
            });

        }
            break;
        default:
            break;
    }
}

#pragma mark - UITextFeiledDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    switch (textField.tag) {
        case AddRemind_NameTextField_Tag:
            [self.dosageTextField resignFirstResponder];
            [self.noteTextField resignFirstResponder];
            [self.drugNameTextField becomeFirstResponder];
            break;
        case AddRemind_DosageTextField_Tag:
            [self.drugNameTextField resignFirstResponder];
            [self.noteTextField resignFirstResponder];
            [self.dosageTextField becomeFirstResponder];
            break;
        case AddRemind_NoteTextField_Tag:
            [self.drugNameTextField resignFirstResponder];
            [self.dosageTextField resignFirstResponder];
            [self.noteTextField becomeFirstResponder];
            
            break;
            
        default:
            break;
    }
    //处理搜索显示
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    switch (textField.tag) {
        case AddRemind_NameTextField_Tag:
            [self.drugNameTextField resignFirstResponder];
            break;
        case AddRemind_DosageTextField_Tag:
            [self.dosageTextField resignFirstResponder];
            break;
        case AddRemind_NoteTextField_Tag:
            [self.noteTextField resignFirstResponder];
            
            break;
            
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:textField];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    
    if (textField.tag == AddRemind_NameTextField_Tag) {
        if (existedLength - selectedLength + replaceLength > 15) {
            [ZXHUD MBShowFailureInView:self.view text:@"药品名称不能大于16个字符" delay:1.2];
            return NO;
        }
    }

    
    if (textField.tag == AddRemind_DosageTextField_Tag) {
        if (range.location > 7) {
            [ZXHUD MBShowFailureInView:self.view text:@"用量字数不能大于8个字符" delay:1.2];
            return NO;
        }
    }
    
    if (textField.tag == AddRemind_NoteTextField_Tag) {
        if (existedLength - selectedLength + replaceLength > 15) {
            [ZXHUD MBShowFailureInView:self.view text:@"用量字数不能大于16个字符" delay:1.2];
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
    switch (textField.tag) {
        case AddRemind_NameTextField_Tag:
            if (keyString.length > 16) {
                textField.text = [textField.text substringToIndex:16];
            }
            break;
        case AddRemind_DosageTextField_Tag:
            break;
        case AddRemind_NoteTextField_Tag:
            if (keyString.length > 16) {
                textField.text = [textField.text substringToIndex:16];
            }
            
            break;
            
        default:
            break;
    }
}

#pragma mark - YDHistoryDrugControllerDelegate
-(void)didHistoryDrugDetailsCellWithModel:(YDSubHistoryOrderModel *)model{
    if (model.drugName) {
        self.drugNameTextField.text = model.drugName;
    }
}

#pragma mark - HTTPRequest
#pragma mark 用药提醒历史订单药品列表
-(void)httpRequestForGetHistoryDrugOrder{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Get_History_Drug_Order) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                id obj = content[@"data"];
                if ([obj isKindOfClass:[NSArray class]]) {
                    [weakSelf.getHistoryBtn setHidden:NO];
                    weakSelf.histOrderArray = [YDHistoryOrderModel mj_objectArrayWithKeyValuesArray:obj];
                }else{
                    [weakSelf.getHistoryBtn setHidden:YES];
                }
            }else{
                [weakSelf.getHistoryBtn setHidden:YES];
            }
        }else{
        }
    }];
}

#pragma mark 添加用药提醒
-(void)httpRequestForAddTakeMedicineRemind{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    
    NSString *drugName = self.drugNameTextField.text;
    NSString *dosage = self.dosageTextField.text;
    
    NSString *unitValue = nil;
    if (self.medicineUnit == nil || self.medicineUnit.length == 0) {
        unitValue = @"片";
    }else{
        unitValue = self.medicineUnit;
    }
    
    NSString *notes = self.noteTextField.text;
    NSString *cycleKey = self.cycleKey;
    NSString *cycleValue = self.drugRemind.text;
    NSString *remindTimes = self.remindTimes;
    NSString *isPush = @"";
    
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }

    if (drugName.length) {
        [dicParams setObject:drugName forKey:@"drugName"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"药品名不能为空" delay:1.2];

        return;
    }
    
    if (dosage.length) {
        [dicParams setObject:dosage forKey:@"dosage"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"每次用量不能为空" delay:1.2];

        return;
    }

    if (unitValue.length) {
        [dicParams setObject:unitValue forKey:@"unitValue"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"用药单位不能为空" delay:1.2];

        return;
    }

    if (notes.length) {
        [dicParams setObject:notes forKey:@"notes"];
    }

    if (cycleKey.length) {
        [dicParams setObject:cycleKey forKey:@"cycleKey"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"用药周期不能为空" delay:1.2];

        return;
    }
    
    if (cycleValue.length) {
        [dicParams setObject:cycleValue forKey:@"cycleValue"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"用药周期不能为空" delay:1.2];

        return;
    }
    
    if (remindTimes.length) {
        [dicParams setObject:remindTimes forKey:@"remindTimes"];
    }else{
        [ZXHUD MBShowFailureInView:self.view text:@"用药时间不能为空" delay:1.2];

        return;
    }
    
    if (isPush.length) {
        [dicParams setObject:isPush forKey:@"isPush"];
    }
    
    [ZXHUD MBShowLoadingInView:self.view text:ZXStatus_Uploading delay:0];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Add_TakeMedicine_Remind) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];
                
                //通知
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_NEW_ADD_DRUGREMIND object:nil];
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

#pragma mark - 注销TextField响应
-(void)resignTextFieldFirstResponder{
    [self.view endEditing:YES];
    [self.drugNameTextField resignFirstResponder];
    [self.dosageTextField resignFirstResponder];
    [self.noteTextField resignFirstResponder];
}

#pragma mark - touchesBegan
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - Lazy
-(YDPopoverView *)durgUnitsView{
    if (!_durgUnitsView) {
        _durgUnitsView = [[YDPopoverView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT)];
        _durgUnitsView.tag = DrugUnitsTag;
        _durgUnitsView.delegate = self;
    }
    return _durgUnitsView;
}

-(YDPopoverView *)durgCycleView{
    if (!_durgCycleView) {
        _durgCycleView = [[YDPopoverView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, ZX_BOUNDS_HEIGHT)];
        _durgCycleView.tag = DrugTimeTag;
        _durgCycleView.delegate = self;
    }
    return _durgCycleView;
}

-(NSMutableArray *)histOrderArray{
    if (!_histOrderArray) {
        _histOrderArray = [[NSMutableArray alloc]init];
    }
    return _histOrderArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
