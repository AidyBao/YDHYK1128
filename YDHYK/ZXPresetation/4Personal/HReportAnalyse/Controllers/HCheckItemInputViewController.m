//
//  HCheckItemInputViewController.m
//  YDHYK
//
//  Created by screson on 2016/12/13.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "HCheckItemInputViewController.h"
#import "DimmingPresentationController.h"
#import "HItemSelectTableCell.h"

typedef enum : NSUInteger {
    HItemSceneTypeChooseType,           //数据类型选择
    HItemSceneTypeChooseRefrenceValue,  //参考值选择
    HItemSceneTypeInputRefrenceValue,   //参考值输入
    HItemSceneTypeChooseResultValue,    //结果值选择
    HItemSceneTypeInputResultValue      //结果值输入
} HItemSceneType;

@interface HCheckItemInputViewController ()<UIViewControllerTransitioningDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    NSInteger refrenceValueIndex;
    NSInteger resultValueIndex;
    NSString * minRefValue;
    NSString * maxRefValue;
    NSString * resultValue;
    UIView * lastView;//上一个视图界面
    
    CGFloat fTypeChooseHeight;
    CGFloat fRefrenceValueChooseHeight;
    CGFloat fResultValueChooseHeight;
    BOOL isHaveDian;
}

@property (nonatomic,assign) NSInteger typeIndex;
@property (nonatomic,assign) HItemDataInputType dataInputType;
@property (nonatomic,strong) NSArray<HItemTypeModel *> * chooseTypeList;
@property (weak, nonatomic) IBOutlet UIView *maskView;

//MARK: - 输入类型选择视图
@property (weak, nonatomic) IBOutlet UIView *vTypeChoose;//输入类型选择视图
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vTypeHeightConstriant;//输入类型视图高度
@property (weak, nonatomic) IBOutlet UITableView *tblTypeChoose;

//MARK: - 参考值选择视图
@property (weak, nonatomic) IBOutlet UIView *vRefreceValueChoose;//参考值选择视图
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vRefrenceValueChooseHeight;
@property (weak, nonatomic) IBOutlet UITableView *tblRefrenceChoose;

//MARK: - 参考值输入视图
//≥:仅填写最小值,≤:仅填写最大值
@property (weak, nonatomic) IBOutlet UIView *vRefrenceValueInput;
@property (weak, nonatomic) IBOutlet UITextField *txtRefrenceMinValue;
@property (weak, nonatomic) IBOutlet UITextField *txtRefrenceMaxValue;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vRefrenceInputHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vRefrenceInputBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vResultInputBottom;

//MARK: - 结果选择
@property (weak, nonatomic) IBOutlet UIView *vResultChoose;
@property (weak, nonatomic) IBOutlet UITableView *tblResultChoose;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vResultChooseHeight;

//MARK: - 结果输入
//≥:仅填写最小值,≤:仅填写最大值
@property (weak, nonatomic) IBOutlet UIView *vResultInput;
@property (weak, nonatomic) IBOutlet UITextField *txtResultValue;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vResultInputHeight;

@end

@implementation HCheckItemInputViewController


+ (void)showRefrenceDataSelectOnVC:(UIViewController *)vc dataOnly:(BOOL)dataOnly typeIndex:(NSInteger)typeIndex completion:(ZXRefrenceValue)completion{
    HCheckItemInputViewController * checkItemInputVC = [[HCheckItemInputViewController alloc] init];
    checkItemInputVC.refrenceValueCompletion = completion;
    checkItemInputVC.typeIndex = typeIndex;
    checkItemInputVC.dataInputType = HItemDataInputTypeRefrence;
    checkItemInputVC.chooseTypeList = [self itemModelList];
    if ([vc isKindOfClass:[UIViewController class]]) {
        [vc presentViewController:checkItemInputVC animated:true completion:nil];
    }
}

+ (void)showResultDataSelectOnVC:(UIViewController *)vc dataOnly:(BOOL)dataOnly typeIndex:(NSInteger)typeIndex completion:(ZXResultValue)completion{
    HCheckItemInputViewController * checkItemInputVC = [[HCheckItemInputViewController alloc] init];
    checkItemInputVC.resultValueCompletion = completion;
    checkItemInputVC.typeIndex = typeIndex;
    checkItemInputVC.dataInputType = HItemDataInputTypeResult;
    checkItemInputVC.chooseTypeList = [self itemModelList];
    if ([vc isKindOfClass:[UIViewController class]]) {
        [vc presentViewController:checkItemInputVC animated:true completion:nil];
    }
}

+ (NSArray <HItemTypeModel *> *)itemModelList{
    NSMutableArray<HItemTypeModel *> * array = [NSMutableArray array];
    HItemTypeModel * m1 = [[HItemTypeModel alloc] init];
    m1.name = @"数值";
    m1.type = HItemTypeInput;
    [array addObject:m1];
    
    HItemTypeModel * m2 = [[HItemTypeModel alloc] init];
    m2.name = @"阴性/阳性";
    m2.type = HItemTypeChoose;
    m2.chooseList = @[@"阴性",@"阳性"];
    [array addObject:m2];
    
    HItemTypeModel * m3 = [[HItemTypeModel alloc] init];
    m3.name = @"+/-";
    m3.type = HItemTypeChoose;
    m3.chooseList = @[@"-",@"+"];
    [array addObject:m3];
    
    return array;
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
    
    isHaveDian = true;
    
    [self.view setBackgroundColor:ZXCLEAR_COLOR];
    [self.maskView setBackgroundColor:ZXCLEAR_COLOR];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(dismissAcion)];
    [self.maskView addGestureRecognizer:tap];
    
    [_tblTypeChoose setSeparatorColor:[UIColor zx_separatorColor]];
    [_tblTypeChoose registerNib:[UINib nibWithNibName:@"HItemSelectTableCell" bundle:nil] forCellReuseIdentifier:@"HItemSelectTableCell1"];
    
    [_tblRefrenceChoose setSeparatorColor:[UIColor zx_separatorColor]];
    [_tblRefrenceChoose registerNib:[UINib nibWithNibName:@"HItemSelectTableCell" bundle:nil] forCellReuseIdentifier:@"HItemSelectTableCell2"];
    
    [_tblResultChoose setSeparatorColor:[UIColor zx_separatorColor]];
    [_tblResultChoose registerNib:[UINib nibWithNibName:@"HItemSelectTableCell" bundle:nil] forCellReuseIdentifier:@"HItemSelectTableCell3"];
    
    [_txtResultValue setBackgroundColor:[UIColor zx_separatorColor]];
    [_txtResultValue setTextColor:[UIColor zx_textColor]];
    [_txtResultValue setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_txtResultValue.layer setCornerRadius:5.0];
    [_txtResultValue.layer setMasksToBounds:true];
    
    [_txtRefrenceMinValue setBackgroundColor:[UIColor zx_separatorColor]];
    [_txtRefrenceMinValue setTextColor:[UIColor zx_textColor]];
    [_txtRefrenceMinValue setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_txtRefrenceMinValue.layer setCornerRadius:5.0];
    [_txtRefrenceMinValue.layer setMasksToBounds:true];
    
    [_txtRefrenceMaxValue setBackgroundColor:[UIColor zx_separatorColor]];
    [_txtRefrenceMaxValue setTextColor:[UIColor zx_textColor]];
    [_txtRefrenceMaxValue setFont:[UIFont zx_titleFontWithSize:zx_title2FontSize()]];
    [_txtRefrenceMaxValue.layer setCornerRadius:5.0];
    [_txtRefrenceMaxValue.layer setMasksToBounds:true];
    
    [self zx_addKeyboardNotification];
    
    lastView = nil;
    [self hideAllViews];
    if (_dataInputType == HItemDataInputTypeRefrence) {
        [self changeSelectSceneType:HItemSceneTypeChooseType];
    }else{
        //[self changeSelectSceneType:HItemSceneTypeChooseType];
        [self tableView:self.tblTypeChoose didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:_typeIndex inSection:0]];
//        HItemTypeModel * typeModel = [_chooseTypeList objectAtIndex:_typeIndex];
//        switch (typeModel.type) {
//            case HItemTypeChoose:
//            {
//                [self changeSelectSceneType:HItemSceneTypeChooseResultValue];//选择
//            }
//                break;
//            case HItemTypeInput:
//            {
//                [self changeSelectSceneType:HItemSceneTypeInputResultValue];//结果
//            }
//                break;
//            default:
//                break;
//        }
    }
}

- (void)setChooseTypeList:(NSArray<HItemTypeModel *> *)chooseTypeList{
    _chooseTypeList = chooseTypeList;
    if (_chooseTypeList) {
        NSInteger count = _chooseTypeList.count;
        [_tblTypeChoose setScrollEnabled:false];
        if (count <= 2) {
            count = 2;
        }else if (count > 5){
            [_tblTypeChoose setScrollEnabled:true];
            count = 5;
        }
        fTypeChooseHeight = (count + 1) * 40;
    }else{
        fTypeChooseHeight = 120;
        fRefrenceValueChooseHeight = 120;
        fResultValueChooseHeight = 120;
    }
}

- (void)hideAllViews{
    _vTypeHeightConstriant.constant = 0;
    _vRefrenceValueChooseHeight.constant = 0;
    _vResultChooseHeight.constant = 0;
    _vRefrenceInputHeight.constant = 0;
    _vResultInputHeight.constant = 0;
}

#pragma mark - 按钮事件
/**返回到类型选择*/
- (IBAction)backToTypeChoose:(id)sender {
    [self changeSelectSceneType:HItemSceneTypeChooseType];
    [_tblRefrenceChoose deselectRowAtIndexPath:[_tblRefrenceChoose indexPathForSelectedRow] animated:false];
    [_tblResultChoose   deselectRowAtIndexPath:[_tblResultChoose   indexPathForSelectedRow] animated:false];
    [self.view endEditing:true];
    [_txtResultValue    setText:@""];
    [_txtRefrenceMinValue setText:@""];
    [_txtRefrenceMaxValue setText:@""];
}

/**参考值输入完成*/
- (IBAction)refrenceValueInputDone:(id)sender {
    NSString * txtMin = [self.txtRefrenceMinValue text];
    NSString * txtMax = [self.txtRefrenceMaxValue text];
    if ([ZXStringUtils isTextEmpty:txtMin] ) {
        [ZXHUD MBShowFailureInView:self.view text:@"请填写最小值" delay:1.5];
        return;
    }else if([ZXStringUtils isTextEmpty:txtMax]){
        [ZXHUD MBShowFailureInView:self.view text:@"请填写最大值" delay:1.5];
        return;
    }else{
        long long min = [txtMin longLongValue];
        long long max = [txtMax longLongValue];
        if (max < min) {
            [ZXHUD MBShowFailureInView:self.view text:@"最大值不能小于最小值" delay:1.5];
            return;
        }
        if (_refrenceValueCompletion) {
            _refrenceValueCompletion(HItemResultTypeValue,txtMin,txtMax,[NSString stringWithFormat:@"%@-%@",txtMin,txtMax],-1);
        }
        [self dismissAcion];
    }
}

/**结果值输入完成*/
- (IBAction)resultValueInputDone:(id)sender {
    NSString * txtResult = [self.txtResultValue text];
    if ([ZXStringUtils isTextEmpty:txtResult]) {
        [ZXHUD MBShowFailureInView:self.view text:@"请填写结果值" delay:1.5];
    }else{
        if (_resultValueCompletion) {
            _resultValueCompletion(HItemResultTypeValue,-1,txtResult);
        }
        [self dismissAcion];
    }
}

#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tblTypeChoose) {//类型选择
        HItemSelectTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HItemSelectTableCell1" forIndexPath:indexPath];
        cell.needHighlight = false;
        HItemTypeModel * typeModel = [_chooseTypeList objectAtIndex:indexPath.row];
        cell.lbItemName.text = typeModel.name;
        return cell;
    }else if (tableView == _tblRefrenceChoose){//参考值
        HItemSelectTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HItemSelectTableCell2" forIndexPath:indexPath];
        cell.needHighlight = true;
        HItemTypeModel * typeModel = [_chooseTypeList objectAtIndex:_typeIndex];
        cell.lbItemName.text = typeModel.chooseList[indexPath.row];
        return cell;
    }else if (tableView == _tblResultChoose){//结果值
        HItemSelectTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HItemSelectTableCell3" forIndexPath:indexPath];
        cell.needHighlight = true;
        HItemTypeModel * typeModel = [_chooseTypeList objectAtIndex:_typeIndex];
        cell.lbItemName.text = typeModel.chooseList[indexPath.row];
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tblTypeChoose) {   //类型选择
        return _chooseTypeList.count;
    }else if (tableView == self.tblRefrenceChoose){//参考值选择
        HItemTypeModel * typeModel = [_chooseTypeList objectAtIndex:_typeIndex];
        return typeModel.chooseList.count;
    }else if (tableView == self.tblResultChoose){//结果值选择
        HItemTypeModel * typeModel = [_chooseTypeList objectAtIndex:_typeIndex];
        return typeModel.chooseList.count;
    }
    return 0;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tblTypeChoose) {//类型选择完成
        _typeIndex = indexPath.row;
        HItemTypeModel * typeModel = [_chooseTypeList objectAtIndex:_typeIndex];
        NSInteger count = typeModel.chooseList.count;
        [_tblRefrenceChoose setScrollEnabled:false];
        [_tblResultChoose   setScrollEnabled:false];
        if (count <= 2) {
            count = 2;
        }else if (count > 5){
            [_tblRefrenceChoose setScrollEnabled:true];
            [_tblResultChoose   setScrollEnabled:true];
            count = 5;
        }
        fRefrenceValueChooseHeight = (count + 1) * 40;
        fResultValueChooseHeight = (count + 1) * 40;
        [_tblRefrenceChoose reloadData];
        [_tblResultChoose   reloadData];
        switch (_dataInputType) {
            case HItemDataInputTypeRefrence://参考值
            {
                switch (typeModel.type) {
                    case HItemTypeChoose:
                    {
                        [self changeSelectSceneType:HItemSceneTypeChooseRefrenceValue];//选择

                    }
                        break;
                    case HItemTypeInput:
                    {
                        [self changeSelectSceneType:HItemSceneTypeInputRefrenceValue];//区间
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            case HItemDataInputTypeResult://结果值
            {
                switch (typeModel.type) {
                    case HItemTypeChoose:
                    {
                        [self changeSelectSceneType:HItemSceneTypeChooseResultValue];//选择
                    }
                        break;
                    case HItemTypeInput:
                    {
                        [self changeSelectSceneType:HItemSceneTypeInputResultValue];//结果
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
    }else if (tableView == self.tblRefrenceChoose){//参考值选择
        refrenceValueIndex = indexPath.row;
        HItemTypeModel * typeModel = [_chooseTypeList objectAtIndex:_typeIndex];
        if (_refrenceValueCompletion) {
            NSString * value = typeModel.chooseList[indexPath.row];
            if ([value isEqualToString:@"+"] ||
                [value isEqualToString:@"-"]) {
                _refrenceValueCompletion(HItemResultTypePlusSub,nil,nil,value,indexPath.row);
            }else{
                _refrenceValueCompletion(HItemResultTypeYinYang,nil,nil,value,indexPath.row);
            }
            
        }
        [self dismissAcion];
    }else if (tableView == self.tblResultChoose){//结果值选择
        HItemTypeModel * typeModel = [_chooseTypeList objectAtIndex:_typeIndex];
        resultValueIndex = indexPath.row;
        if (_resultValueCompletion) {
            NSString * value = typeModel.chooseList[indexPath.row];
            if ([value isEqualToString:@"+"] ||
                [value isEqualToString:@"-"]) {
                _resultValueCompletion(HItemResultTypePlusSub,indexPath.row,typeModel.chooseList[indexPath.row]);
            }else{
                _resultValueCompletion(HItemResultTypeYinYang,indexPath.row,typeModel.chooseList[indexPath.row]);
            }
        }
        [self dismissAcion];
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

- (void)changeSelectSceneType:(HItemSceneType)type{
    [self checkLastSelectViewByType:type];
    switch (type) {
        case HItemSceneTypeChooseType:
        {
            _vTypeHeightConstriant.constant = fTypeChooseHeight;
        }
            break;
        case HItemSceneTypeChooseRefrenceValue:
        {
            _vRefrenceValueChooseHeight.constant = fRefrenceValueChooseHeight;
        }
            break;
        case HItemSceneTypeChooseResultValue:
        {
            _vResultChooseHeight.constant = fResultValueChooseHeight;
        }
            break;
        case HItemSceneTypeInputRefrenceValue:
        {
            _vRefrenceInputHeight.constant = 120;
            [_txtRefrenceMinValue becomeFirstResponder];
        }
            break;
        case HItemSceneTypeInputResultValue:
        {
            _vResultInputHeight.constant = 120;
            [_txtResultValue becomeFirstResponder];
        }
            break;

        default:
            break;
    }
    [UIView animateWithDuration:0.35 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)checkLastSelectViewByType:(HItemSceneType)type{
    if (lastView ) {
        if (lastView == _vTypeChoose) {//类型选择界面
            _vTypeHeightConstriant.constant = 0;
        }else if (lastView == _vRefreceValueChoose){//参考值选择界面
            _vRefrenceValueChooseHeight.constant = 0;
        }else if (lastView == _vResultChoose){//结果值选择界面
            _vResultChooseHeight.constant = 0;
        }else if (lastView == _vRefrenceValueInput){//参考值输入界面
            _vRefrenceInputHeight.constant = 0;
        }else if (lastView == _vResultInput){//参考值选择界面
            _vResultInputHeight.constant = 0;
        }
    }
    switch (type) {
        case HItemSceneTypeChooseType:
        {
            lastView = _vTypeChoose;
        }
            break;
        case HItemSceneTypeChooseRefrenceValue:
        {
            lastView = _vRefreceValueChoose;
        }
            break;
        case HItemSceneTypeChooseResultValue:
        {
            lastView = _vResultChoose;
        }
            break;
        case HItemSceneTypeInputRefrenceValue:
        {
            lastView = _vRefrenceValueInput;
        }
            break;
        case HItemSceneTypeInputResultValue:
        {
            lastView = _vResultInput;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - KeyBoard
- (void)zx_keyboardWillHideTimeInteval:(double)dt notice:(NSNotification *)notice{
    if ([_txtResultValue isFirstResponder]) {
        _vResultInputBottom.constant = 0;
    }else{
        _vRefrenceInputBottom.constant = 0;
    }
    
    [UIView animateWithDuration:dt animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)zx_keyboardWillChangeFrameBeginRect:(CGRect)beginRect endRect:(CGRect)endRect timeInterval:(double)dt notice:(NSNotification *)notice{
    if ([_txtResultValue isFirstResponder]) {
        _vResultInputBottom.constant = endRect.size.height;
    }else{
        _vRefrenceInputBottom.constant = endRect.size.height;
    }
    [UIView animateWithDuration:dt animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location > 7) {
        return false;
    }
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
    
            //小数点
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                    
                }
//                if (single == '0') {
//                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
//                    return NO;
//                    
//                }
            }else{
                if (single == '0') {
                    if (isHaveDian || [[textField.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"0"]) {
                        NSRange ran=[textField.text rangeOfString:@"."];
                        unsigned long tt=range.location-ran.location;
                        if (tt <= 3){
                            return true;
                        }else{
                            return false;
                        }
                    }
                }else{
                    if ([textField.text length] == 1 && [textField.text isEqualToString:@"0"] && single != '.') {//第一位为0 第二位不为0 也不是小数点
                        [textField setText:[NSString stringWithCharacters:&single length:1]];
                        return NO;
                    }
                }
            }
            //输入的小数点
            if (single=='.'){
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    unsigned long tt=range.location-ran.location;
                    if (tt <= 3){
                        return YES;
                    }else{
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    return YES;
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
