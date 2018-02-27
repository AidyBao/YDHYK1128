//
//  YDEditProfileTableViewController.m
//  ydhyk
//
//  Created by Aidy Bao on 2016/11/12.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDEditProfileTableViewController.h"
#import "YDEidtNameViewController.h"
#import "YDSixAgeView.h"
/** 收获地址*/
#import "YDReceiverAddressTableViewController.h"
/** 年龄段模型*/
#import "YDAgeGroupModel.h"

#define EditProfile_SexView_Tag 3101
#define EditProfile_AgeView_Tag 3102

static NSString *const ProfileCellID = @"ProfileCellID";
@interface YDEditProfileTableViewController ()<YDSixAgeViewDelegate,YDEidtNameViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/* 标题*/
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *address;

/* 详情*/
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;

/* 弹出框*/
@property (nonatomic,strong) YDSixAgeView *sexView;
@property (nonatomic,strong) YDSixAgeView *ageView;

/* 性别数据*/
@property (nonatomic,strong) NSArray *sexArray;
/* 年龄段数据*/
@property (nonatomic,strong) NSArray *ageArray;
/* 头像*/
@property (nonatomic,strong) UIImage *headImage;


@end

@implementation YDEditProfileTableViewController

+(instancetype)instantiateFromStoryboard{
    return [[UIStoryboard storyboardWithName:@"EditProfile" bundle:nil] instantiateViewControllerWithIdentifier:@"YDEditProfileTableViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑资料";
    //基本设置
    [self setupBaseUI];
    
    //获取用户信息
    [self getUserInformation];
    
    //获取年龄段
    if (self.ageArray.count == 0) {
        [self httpRequestForGetAgeGroup];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - 基本设置
-(void)setupBaseUI{
    self.tableView.backgroundColor = [UIColor zx_assistColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    self.iconImageView.layer.cornerRadius = 35.0;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.iconLabel.textColor = [UIColor zx_textColor];
    self.name.textColor = [UIColor zx_textColor];
    self.sex.textColor = [UIColor zx_textColor];
    self.age.textColor = [UIColor zx_textColor];
    self.tel.textColor = [UIColor zx_textColor];
    self.address.textColor = [UIColor zx_textColor];
    
    self.nameLabel.textColor = [UIColor zx_sub2TextColor];
    self.sexLabel.textColor = [UIColor zx_sub2TextColor];
    self.ageLabel.textColor = [UIColor zx_sub2TextColor];
    self.telLabel.textColor = [UIColor zx_sub2TextColor];
}

#pragma mark - 获取用户信息
-(void)getUserInformation{
    //头像
//    NSString *iconStr = [[YDAPPManager shareManager] getUserHeadPortraitFilesStr];
    
//    if (iconStr.length) {
//        [self.iconImageView setImageWithURL:[NSURL URLWithString:iconStr] placeholderImage:nil];
//    }else{
//        [self.iconImageView setImageWithURL:[NSURL URLWithString:@""] placeholderImage:nil];
//    }
    id headerUrl = [[YDAPPManager shareManager]  getUserHeadPortraitFilesStr];
    if ([headerUrl isKindOfClass:[NSString class]] && [headerUrl length]) {
        if ([[[YDAPPManager shareManager] getUserSex] integerValue] == 0) {//女
            [self.iconImageView setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:@"touxiang-woman"]];
        }else{
            [self.iconImageView setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:@"touxiang-man"]];
        }
        
    }else{
        if ([[[YDAPPManager shareManager] getUserSex] integerValue] == 0) {//女
            [self.iconImageView setImage:[UIImage imageNamed:@"touxiang-woman"]];
        }else{
            [self.iconImageView setImage:[UIImage imageNamed:@"touxiang-man"]];
        }
    }

    //姓名
    NSString *nameStr = [[YDAPPManager shareManager] getUserName];
    if (nameStr.length) {
        self.nameLabel.text = nameStr;
    }else{
       self.nameLabel.text = @"";
    }
    
    //性别
    NSInteger sex = -1;
    sex = [[YDAPPManager shareManager] getUserSex].integerValue;
    if(sex != -1){
        switch (sex) {
            case 0:
                self.sexLabel.text = @"女";
                break;
            case 1:
                self.sexLabel.text = @"男";
                break;
                
            default:
                break;
        }
    }else{
        self.sexLabel.text = @"";
    }
    
    //年龄
    NSString *ageStr = [[YDAPPManager shareManager] getUserAgeGroups];
    if (ageStr.length) {
        self.ageLabel.text = ageStr;
    }else{
        self.ageLabel.text = @"";
    }
    
    //电话
    NSString *telStr = [[YDAPPManager shareManager] getUserTelephone];
    if (telStr.length) {
        self.telLabel.text =  [telStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        self.telLabel.text = @"";
    }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self selectedHeadPortraits];
                break;
            case 1:
            {//编辑名字
                YDEidtNameViewController *editNameVC = [[YDEidtNameViewController alloc]init];
                editNameVC.delegate = self;
                editNameVC.hidesBottomBarWhenPushed = YES;
                editNameVC.name = self.nameLabel.text;
                [self.navigationController pushViewController:editNameVC animated:YES];
            }
                
                break;
            case 2:
            {
                [self.sexView removeFromSuperview];
                _sexView = nil;
                
                [self.sexView show];
                self.sexView.titleStr = @"性别";
                self.sexView.dataArray =self.sexArray;
                
                if (self.sexLabel.text) {
                    self.sexView.defaultStr = self.sexLabel.text;
                }
            }
                break;
            case 3:
            {
                [self.ageView removeFromSuperview];
                _ageView = nil;
                _ageArray = nil;
                
                [self.ageView show];
                self.ageView.titleStr = @"年龄";
                self.ageView.dataArray =self.ageArray;
                
                if (self.ageLabel.text) {
                    self.ageView.defaultStr = self.ageLabel.text;
                }
            }
                break;
            default:
                break;
        }
    }else{
        YDReceiverAddressTableViewController *addressVC = [[YDReceiverAddressTableViewController alloc]init];
        addressVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressVC animated:YES];
    }
}

#pragma mark - YDSixAgeViewDelegate(性别/年龄)
-(void)didSelectedCellIndexPathWithString:(NSString *)string WithTag:(NSInteger)tag{
    switch (tag) {
        case EditProfile_SexView_Tag:{//性别
            self.sexLabel.text = string;
            
            NSUInteger sex = -1;
            if (string) {
                if ([string isEqualToString:@"男"]) {
                    sex = 1;
                }else if ([string isEqualToString:@"女"]){
                    sex = 0;
                }
            }
            
            //上传性别
            [self  httpRequestForModiySexWithSex:sex];
        }
            break;
        case EditProfile_AgeView_Tag:{//年龄
            self.ageLabel.text = string;
            
            NSInteger ageGroup = -1;
            if ([string isEqualToString:UNDERTWENTY]) {
                ageGroup = 0;
            }
            if ([string isEqualToString:TWENTY_THIRTY]) {
                ageGroup = 1;
            }
            if ([string isEqualToString:THIRTY_FORTY]) {
                ageGroup = 2;
            }
            if ([string isEqualToString:FORTY_FIFTY]) {
                ageGroup = 3;
            }
            if ([string isEqualToString:ODERFIFTY]) {
                ageGroup = 4;
            }

            //上传年龄段
            [self  httpRequestForAgeGroupsWithAgeGroups:ageGroup];
        }

            break;
        default:
            break;
    }
}

#pragma mark - YDEidtNameViewControllerDelegate(性别)
-(void)FeedbackString:(NSString *)string{
    self.nameLabel.text = string;
}

#pragma mark - 保存
#pragma mark 性别
-(void)saveUserSexWith:(NSInteger)sex{
    
    [[YDAPPManager shareManager] getLoginBaseUser].sex = [NSString stringWithFormat:@"%zd",sex];
    [[YDAPPManager shareManager] saveUserSex];
    
    [[YDAPPManager shareManager] getLoginBaseUser].sexStr = self.sexLabel.text;
    [[YDAPPManager shareManager] saveUserSexStr];
}

#pragma mark 年龄段
-(void)saveUserAgeGroups:(NSInteger)ageGroups{
    [[YDAPPManager shareManager] getLoginBaseUser].ageGroups = [NSString stringWithFormat:@"%zd",ageGroups];
    [[YDAPPManager shareManager] saveUserAgeGroup];
}

#pragma mark 头像
-(void)saveUserHeadProtrait:(NSString *)filePath{
    [[YDAPPManager shareManager] getLoginBaseUser].headPortraitFilesStr = filePath;
    [[YDAPPManager shareManager] saveUserHeadProtraitStr];
}

#pragma mark - HTTP
#pragma mark  修改性别
-(void)httpRequestForModiySexWithSex:(NSInteger)sex{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    
    if (sex != -1) {
        [dicParams setObject:[NSString stringWithFormat:@"%zd",sex] forKey:@"sex"];
    }
   
    __weak typeof(self) weakSelf = self;
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Modify_Profile_Sex) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];
                //保存性别
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [weakSelf saveUserSexWith:sex];
                });
                
                //移除控件
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:1.0 animations:^{
                    } completion:^(BOOL finished) {
                        [weakSelf.sexView removeFromSuperview];
                        _sexView = nil;
                    }];
                });
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark  修改年龄段
-(void)httpRequestForAgeGroupsWithAgeGroups:(NSInteger)ageGroup{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    if (ageGroup != -1) {
        [dicParams setObject:[NSString stringWithFormat:@"%zd",ageGroup] forKey:@"ageGroups"];
    }
    
    __weak typeof(self) weakSelf = self;
    [ZXHUD MBShowLoadingInView:self.view text:ZX_LOADING_TEXT delay:0];
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Modify_Profile_AgeGroups) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:self.view animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];

                
                //保存年龄段
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [weakSelf saveUserAgeGroups:ageGroup];
                });
                
                //移除控件
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:1.0 animations:^{
                    } completion:^(BOOL finished) {
                        [weakSelf.ageView removeFromSuperview];
                        _ageView = nil;
                    }];
                });
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];

}

#pragma mark 上传更新图片
-(void)httpRequestForUploadHeadImage{
    
    //1.图片处理
    // 固定图片方向
    UIImage *fixImage = [UIImage fixOrientation:self.headImage];
    // 剪切图片
    UIImage *cutImage = [UIImage cutImageToSquare:fixImage];
    //上传头像 并且完成压缩功能
    UIImage *uploadImag = [UIImage scaleImageWithImage:cutImage toSize:CGSizeMake(300, 300)];
    
    //2.上传
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }

    NSArray *array = [[NSArray alloc]initWithObjects:uploadImag, nil];
    
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine uploadImageToResourceURL:ZXIMG_Address(ZXAPI_RESOURCE_URL) images:array compressQulity:1 filePath:ZXPathThumb token:token params:dicParams zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                //获得图片相对地址
                NSString *filePath = content[@"filePath"];
                //更新会员头像
                [weakSelf httpRequestForModifyUserIocnWithFilePath:filePath];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];

            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];

        }
    }];
}

#pragma mark 更新用户头像
-(void)httpRequestForModifyUserIocnWithFilePath:(NSString *)filePath{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager] getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    
    NSString *headString = nil;
    if (filePath.length) {
        headString = [NSString stringWithFormat:@"%@",filePath];
        [dicParams setObject:headString forKey:@"headPortrait"];
    }
    
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Modify_Profile_HeadPortrait) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                //更新头像
                
                NSString *imageStr =  ZXIMG_Address(headString);
                
                [weakSelf.iconImageView setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
                //保存头像
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [weakSelf saveUserHeadProtrait:imageStr];
                });
                
                [ZXHUD MBShowSuccessInView:self.view text:content[@"msg"] delay:1.2];
            }else{
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
                
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}

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
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Get_Profile_AgeGroup) params:dicParas token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            if (status == ZXAPI_SUCCESS) {//
                id obj = content[@"data"];
                if ([obj isKindOfClass:[NSArray class]]) {
                    //模型转换
                    NSMutableArray *tempArray = [YDAgeGroupModel mj_objectArrayWithKeyValuesArray:content[@"data"]];
                    //保存服务器返回年龄段
                    [weakSelf saveAgeGroupArrayWithArray:tempArray];
                }
                
            }else{//
                [ZXHUD MBShowFailureInView:self.view text:content[@"msg"] delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
        }
    }];
}


#pragma mark - 保存服务器返回年龄段
-(void)saveAgeGroupArrayWithArray:(NSMutableArray *)temArray{
    NSMutableArray *ageGroupArray = [NSMutableArray array];
    for (YDAgeGroupModel *model in temArray) {
        [ageGroupArray addObject:model.value];
    }
    [[YDAPPManager shareManager] saveAgeGroupArray:ageGroupArray];
}

#pragma mark - 头像
-(void)selectedHeadPortraits{
    
    UIAlertController *alertController = nil;
    if (ZX_IS_IPAD) {
        alertController = [UIAlertController alertControllerWithTitle:nil message:nil  preferredStyle:UIAlertControllerStyleAlert];
    }else{
        alertController = [UIAlertController alertControllerWithTitle:nil message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
    }
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alertController addAction:cancelAction];
    
    //拍照
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"拍照");
        [self chooseImageFromCamera];
    }];
    [alertController addAction:moreAction];
    
    //从手机相册选择
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"手机相册");
        [self chooseImageFromAlbum];
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 手机相册
- (void)chooseImageFromAlbum{
    self.editing = NO;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        [ZXHUD MBShowFailureInView:self.view text:@"相册打开失败" delay:1.2];
        return;
    }
    UIImagePickerController *imagePickeVc = [[UIImagePickerController alloc] init];
    imagePickeVc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickeVc.delegate = self;
    [self presentViewController:imagePickeVc animated:YES completion:nil];
}

#pragma mark 拍照
- (void)chooseImageFromCamera{
    self.editing = NO;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [ZXHUD MBShowFailureInView:self.view text:@"相机打开失败" delay:1.2];
        return;
    }
    UIImagePickerController *imagePickeVc = [[UIImagePickerController alloc] init];
    imagePickeVc.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickeVc.delegate = self;
    [self presentViewController:imagePickeVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.headImage = image;
    
    //2.上传服务器
    [self httpRequestForUploadHeadImage];
    
    //3.dismiss
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Lazy
-(YDSixAgeView *)sexView{
    if (!_sexView) {
        _sexView = [[YDSixAgeView alloc]init];
        _sexView.tag = EditProfile_SexView_Tag;
        _sexView.delegate = self;
    }
    return _sexView;
}

-(YDSixAgeView *)ageView{
    if (!_ageView) {
        _ageView = [[YDSixAgeView alloc]init];
        _ageView.tag = EditProfile_AgeView_Tag;
        _ageView.delegate = self;
    }
    return _ageView;
}

-(NSArray *)sexArray{
    if (!_sexArray) {
        _sexArray = [[NSArray alloc]initWithObjects:@"男",@"女", nil];
    }
    return _sexArray;
}

-(NSArray *)ageArray{
    if (!_ageArray) {
        NSArray *array = [[YDAPPManager shareManager]getAgeGroupArray];
        _ageArray = [[NSArray alloc]initWithArray:array];
    }
    return _ageArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
