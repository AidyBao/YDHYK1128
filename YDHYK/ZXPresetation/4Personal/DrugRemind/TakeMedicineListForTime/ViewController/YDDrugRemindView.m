//
//  YDDrugRemindView.m
//  ydhyk
//
//  Created by 120v on 2016/11/4.
//  Copyright © 2016年 120v. All rights reserved.
//

#import "YDDrugRemindView.h"
#import "LLCarouselCollectionLayout.h"
#import "YDRemindNoneViewCell.h"
#import "YDRemindInfoViewCell.h"
/** 药品详情*/
#import "YDMedicineDetailView.h"
/** 用药提醒按提醒时间分类*/
#import "YDRemindTimeModel.h"
/** 时间选择器*/
#import "ZXDateView.h"
#import "ZXOrderDictionary.h"

@interface YDDrugRemindView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
/** 顶部滑动视图*/
@property (nonatomic,strong) UICollectionView *collectionView;
/** 分页*/
@property (nonatomic,strong) UIPageControl *pageControl;
/** 用药提醒按提醒时间分类数据*/
@property (nonatomic,strong) NSMutableArray *remindTimeArray;

@property (nonatomic,assign) BOOL isNoData;

@end

@implementation YDDrugRemindView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor zx_navbarColor];
        //HTTP
        [self httpRequestForSearchByRemindTime];
        
        //pageControl
        [self addSubview:self.pageControl];
        self.pageControl.numberOfPages = self.remindTimeArray.count;
        
        self.isNoData = TRUE;
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNewAddTime) name:ZXNOTICE_NEW_ADD_DRUGREMIND object:nil];
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //collectionView
    self.collectionView.frame = CGRectMake(0, 7, self.bounds.size.width, 229);
    //pageControl
    self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.bounds.size.width, 32);

}

#pragma mark - 通知_刷新新增用药提醒
-(void)refreshNewAddTime{
    
    self.isNoData = FALSE;
  
    [self httpRequestForSearchByRemindTime];
}

#pragma mark - HTTPRequest
#pragma mark 用药提醒按提醒时间分类查询
-(void)httpRequestForSearchByRemindTime{
    
    [ZXEmptyView dismissInView:self];

    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:memberID forKey:@"memberId"];
    }

    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Search_ByRemindTime) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        
        
        if (success) {
            if (status == ZXAPI_SUCCESS) {
                
                [self.remindTimeArray removeAllObjects];
                
                id obj = content[@"data"];
                
                if ([obj isKindOfClass:[NSDictionary class]] && [obj count]) {
                    
                    NSDictionary *dict = obj;
                    if (dict) {
                        
                        //有序字典
                        MutableOrderedDictionary *orderedDict = [ZXOrderDictionary orderedWithDictionary:dict];
                        
                        
                        for (NSString *key in orderedDict.allKeys) {
                            NSMutableDictionary *temDict = [[NSMutableDictionary alloc]init];
                            NSArray *array =  [orderedDict objectForKey:key];
                            [temDict setObject:[YDRemindTimeModel mj_objectArrayWithKeyValuesArray:array] forKey:key];
                            [self.remindTimeArray addObject:temDict];
                        }
                    }
                }
                //此处加1个对象的目的是方便后续加载没有数据的Cell
                if (self.remindTimeArray.count == 0) {
                    self.isNoData = TRUE;
                    [self.remindTimeArray addObject:@"1"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.pageControl.numberOfPages = self.remindTimeArray.count;
                        [self.collectionView reloadData];
                    });
                }else{
                    self.isNoData = FALSE;
                    
                    //选中距系统时间最近的item
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.pageControl.numberOfPages = self.remindTimeArray.count;
                        [self.collectionView reloadData];
                        
                        //选中距当前时间最近的cell
                        [self selectedNearestTimeItem];
                    });
                }
            }else{//系统异常
                [ZXHUD MBShowFailureInView:[ZXRootViewControllers window] text:content[@"msg"] delay:1.2];
            }
        }else{
            [ZXHUD MBShowFailureInView:[ZXRootViewControllers window] text:errorMsg delay:1.2];
        }
    }];
}

#pragma mark - 选中距系统时间最近的item
-(void)selectedNearestTimeItem{
    [ZXOrderDictionary sortedWithArray:self.remindTimeArray completion:^(NSInteger index) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }];
}

#pragma mark 用药提醒修改提醒时间
-(void)httpRequestForModifyRemindTimeWithCell:(YDRemindInfoViewCell*)cell WithDetailID:(NSString *)detailId withDate:(NSString *)dateStr{
    NSMutableDictionary * dicParams =[NSMutableDictionary dictionary];
    NSString *memberID = [[YDAPPManager shareManager]getMemberId];
    NSString *token = [[YDAPPManager shareManager]getUserToken];
    if (memberID) {
        [dicParams setObject:[NSString stringWithFormat:@"%@",memberID] forKey:@"memberId"];
    }
    
    if (detailId) {
        [dicParams setObject:[NSString stringWithFormat:@"%@",detailId] forKey:@"detailIds"];
    }
    
    if (dateStr) {
        [dicParams setObject:dateStr forKey:@"remindTime"];
    }
    
    __weak typeof(self) weakSelf = self;
    [ZXNetworkEngine asycnRequestWithURL:ZXAPI_Address(ZXAPI_Modify_RemindTime) params:dicParams token:token method:POST zxCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        if (success) {
            [ZXHUD MBShowSuccessInView:weakSelf text:content[@"msg"] delay:1.0f];
            cell.drugTime = dateStr;
            
            //通知刷新数据
            [self refreshNewAddTime];
            
            //通知刷新已添加提醒
            [[NSNotificationCenter defaultCenter] postNotificationName:ZXNOTICE_NOTIFICATION_ModifyTime object:nil];
            
        }else{
            [ZXHUD MBShowFailureInView:weakSelf text:errorMsg delay:1.0f];
        }
    }];
}

#pragma mark - 查看详情
-(void)checkTakeMedicineInfromationByTimeWithCell:(YDRemindInfoViewCell *)cell{
    
    [cell setHandleDidCheckInfoBtn:^(NSDictionary *dataDict){
        YDMedicineDetailView *detailView = [[YDMedicineDetailView alloc] init];
        detailView.isTakeMedicine = YES;
        detailView.dataDict = dataDict;
        [detailView show];
    }];
}

#pragma mark - 修改时间
-(void)modifyTakeMedicineTimeWithCell:(YDRemindInfoViewCell *)cell{
    
    __block YDRemindInfoViewCell *blockCell = cell;
    [cell setModifyRemindTime:^(NSDictionary *dataDict) {
        //1. 显示
        ZXDateView *dateView = [[ZXDateView alloc]init];
        dateView.title = @"修改用药时间";
        [dateView show];
        
        //2. 取出id
        NSArray *tempArray = [dataDict objectForKey:dataDict.allKeys.firstObject];
        NSString *detailIds = [[NSString alloc]init];
        for (int i = 0;i < tempArray.count;i ++) {
            YDRemindTimeModel *model = tempArray[i];
            NSString *defailtID = model.detailId;
            if (tempArray.count == 1) {
                detailIds = [NSString stringWithFormat:@"%@",defailtID];
            }else{
                if (i == 0) {
                    detailIds = [NSString stringWithFormat:@"%@",defailtID];
                }else{
                    detailIds = [NSString stringWithFormat:@"%@,%@",detailIds,defailtID];
                }
            }
        }

        //3.获得时间
        dateView.ZXDateViewBlock = ^(NSString *dateStr){
            
            //4.上传
            [self httpRequestForModifyRemindTimeWithCell:blockCell  WithDetailID:detailIds withDate:dateStr];
        };
    }];
}


#pragma mark - UICollectionViewDataSoure
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (self.isNoData == TRUE && self.remindTimeArray.count == 1) {
        count = 1;
    }else{
        count = self.remindTimeArray.count;
    }
    
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    id obj = [self.remindTimeArray objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[NSDictionary class]] && obj && self.isNoData == FALSE) {
        YDRemindInfoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[YDRemindInfoViewCell reuseID] forIndexPath:indexPath];
        
        cell.dataDict = obj;
        
        //查看详情回调
        [self checkTakeMedicineInfromationByTimeWithCell:cell];
        
        //修改时间回调
        [self modifyTakeMedicineTimeWithCell:cell];
        
        return cell;

        
    }else{//没有设置用药提醒
        return [collectionView dequeueReusableCellWithReuseIdentifier:[YDRemindNoneViewCell reuseID] forIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.remindTimeArray.count > 0) {
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.remindTimeArray.count) {
        self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x/(scrollView.bounds.size.width - 56 - 10))%self.remindTimeArray.count;
    }
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

#pragma mark - lazy
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        LLCarouselCollectionLayout *layout = [[LLCarouselCollectionLayout alloc] init];

         _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor zx_navbarColor];
        [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        //已经设置用药提醒
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YDRemindInfoViewCell class]) bundle:nil] forCellWithReuseIdentifier:[YDRemindInfoViewCell reuseID]];
        //没有设置用药提醒
        [_collectionView registerClass:[YDRemindNoneViewCell class] forCellWithReuseIdentifier:[YDRemindNoneViewCell reuseID]];
        
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSMutableArray *)remindTimeArray{
    if (!_remindTimeArray) {
        _remindTimeArray = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _remindTimeArray;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = ZXRGB_COLOR(108, 135, 239);
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor zx_navbarColor];
    }
    return _pageControl;
}


@end
