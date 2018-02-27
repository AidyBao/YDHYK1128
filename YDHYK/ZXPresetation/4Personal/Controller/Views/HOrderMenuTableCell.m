//
//  HOrderMenuTableCell.m
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HOrderMenuTableCell.h"
#import "HOrderMenuCollectionCell.h"
#import "ZXAllUnReadCountModel.h"

@interface HOrderMenuTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray * arrImageNames;
    NSArray * arrTitles;
    ZXAllUnReadCountModel * unReadMsgModel;
}

@property (weak, nonatomic) IBOutlet UICollectionView *orderMenuCCView;

@end

@implementation HOrderMenuTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    arrImageNames = @[@"h_order_1",@"h_order_2",@"h_order_3",@"h_order_4",@"h_order_5"];
    arrTitles = @[@"待付款",@"待提货",@"待发货",@"待收货",@"已完成"];
    [_orderMenuCCView setScrollEnabled:false];
    [_orderMenuCCView registerNib:[UINib nibWithNibName:@"HOrderMenuCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HOrderMenuCollectionCell"];
    [ZXNotificationCenter addObserver:self selector:@selector(updateUnReadCount:) name:ZXNOTICE_UPDATE_UNREAD_MSG_COUNT object:nil];
}


- (void)updateUnReadCount:(NSNotification *)notice{
    if ([notice.object isKindOfClass:[ZXAllUnReadCountModel class]]) {
        unReadMsgModel = (ZXAllUnReadCountModel *)notice.object;
        [self.orderMenuCCView reloadData];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HOrderMenuCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HOrderMenuCollectionCell" forIndexPath:indexPath];
    [cell setTitle:arrTitles[indexPath.row] image:arrImageNames[indexPath.row]];
    [cell setUNReadMessageCount:0];
    switch (indexPath.row) {
        case 0://待付款
        {
            if (unReadMsgModel) {
                [cell setUNReadMessageCount:unReadMsgModel.notPayNum];
            }
        }
            break;
        case 1://待提货
        {
            if (unReadMsgModel) {
                [cell setUNReadMessageCount:unReadMsgModel.notTakeNum];
            }
        }
            break;
        case 2://待发货
        {
            if (unReadMsgModel) {
                [cell setUNReadMessageCount:unReadMsgModel.notSendNum];
            }
        }
            break;
        case 3://待收货
        {
            if (unReadMsgModel) {
                [cell setUNReadMessageCount:unReadMsgModel.notReciveNum];
            }
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ZX_BOUNDS_WIDTH / 5, 84);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(orderMenuActionsWithIndex:)]) {
        [_delegate orderMenuActionsWithIndex:indexPath.row + 1];
    }
}


- (void)dealloc{
    [ZXNotificationCenter removeObserver:self name:ZXNOTICE_UPDATE_UNREAD_MSG_COUNT object:nil];
}


@end
