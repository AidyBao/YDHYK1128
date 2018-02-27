//
//  YDNoMemeberCardView.m
//  YDHYK
//
//  Created by 120v on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "YDNoMemeberCardView.h"
/** cell*/
#import "YDListTableViewCell.h"
/** header*/
#import "YDJoinMemberHeaderView.h"

static NSString *const joinCell = @"joinCell";
static NSString *const joinHeaderCell = @"joinHeaderCell";

@interface YDNoMemeberCardView()<UITableViewDelegate,UITableViewDataSource,YDListTableViewCellDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tabelView;

@end

@implementation YDNoMemeberCardView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //
        [self addSubview:self.tabelView];
        
        //数据请求
        [self httpRequestForClosestDrugstoreList];
    }
    return self;
}

-(void)layoutSubviews{
    
}

#pragma mark - HTTPRequest
-(void)httpRequestForClosestDrugstoreList{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager] getUserToken];
    CLLocation *location = ((AppDelegate *)[UIApplication sharedApplication].delegate).userlocation;
    NSString *latitude =[NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];

    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }
    if (latitude) {
        [dicParams setObject:latitude forKey:@"latitude"];
    }
    if (longitude) {
        [dicParams setObject:longitude forKey:@"longitude"];
    }

    [ZXHUD MBShowLoadingInView:[ZXRootViewControllers window] text:ZX_LOADING_TEXT delay:0];
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Closes_Drugstore_List) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [ZXHUD MBHideForView:[ZXRootViewControllers window] animate:true];
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                NSArray *array = content[@"data"];
                if (array !=nil && ![array isKindOfClass:[NSNull class]] &&array.count !=0) {
                    [weakSelf.dataArray addObjectsFromArray: [YDClosesListModel mj_objectArrayWithKeyValuesArray:array]];
                }
            }else{
                [ZXEmptyView showNoDataInView:weakSelf text1:@"没有数据" text2:nil heightFix:0];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tabelView reloadData];
            });
        }else{
            [ZXEmptyView showNetworkErrorInView:self heightFix:0 refreshAction:^{
                [ZXEmptyView dismissInView:self];
                [self httpRequestForClosestDrugstoreList];
            }];
        }
    }];
    
}


#pragma mark - UITabelViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 141;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YDListTableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:joinCell forIndexPath:indexPath];
    listCell.delegate = self;
    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    listCell.dataModel = [self.dataArray objectAtIndex:indexPath.row];
    
    return listCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 258;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    YDJoinMemberHeaderView *headerView = [[YDJoinMemberHeaderView alloc]initWithFrame:CGRectMake(0, 0, ZX_BOUNDS_WIDTH, 258)];
   
    return headerView;
}


#pragma mark - YDListTableViewCellDelegate
#pragma mark 定位
-(void)didListViewLocationButton:(UIButton *)sender withModel:(YDClosesListModel *)model{
    if ([self.delegate respondsToSelector:@selector(didNoMemeberCardViewLocationButton:withModel:)]) {
        [self.delegate didNoMemeberCardViewLocationButton:sender withModel:model];
    }
}
#pragma mark 电话
-(void)didListViewTelephoneButton:(UIButton *)sender withModel:(YDClosesListModel *)model{
    if ([self.delegate respondsToSelector:@selector(didNoMemeberCardViewTelephoneButton:withModel:)]) {
        [self.delegate didNoMemeberCardViewTelephoneButton:sender withModel:model];
    }
}
#pragma mark 加入会员
-(void)didListViewJoinMemberButton:(UIButton *)sender withModel:(YDClosesListModel *)model{
    if ([self.delegate respondsToSelector:@selector(didNoMemeberCardViewMemberButton:withModel:)]) {
        [self.delegate didNoMemeberCardViewMemberButton:sender withModel:model];
    }
}

#pragma mark 购药
-(void)didListViewBuyButton:(UIButton *)sender withModel:(YDSearchModel *)model{
    
}

#pragma mark - Getter
-(UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStyleGrouped];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        _tabelView.backgroundColor = [UIColor zx_assistColor];
        [_tabelView setShowsVerticalScrollIndicator:NO];
        [_tabelView registerNib:[UINib nibWithNibName:NSStringFromClass([YDListTableViewCell class]) bundle:nil] forCellReuseIdentifier:joinCell];
//        [_tabelView registerClass:[YDJoinMemberHeaderView class] forHeaderFooterViewReuseIdentifier:joinHeaderCell];
    }
    return _tabelView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end
