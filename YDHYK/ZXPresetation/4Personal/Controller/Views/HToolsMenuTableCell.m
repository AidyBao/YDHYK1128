//
//  HToolsMenuTableCell.m
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HToolsMenuTableCell.h"
#import "HToolsMenuCollectionCell.h"
#import "ZXAllUnReadCountModel.h"

@interface HToolsMenuTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray * arrImageNames;
    NSArray * arrTitles;
    ZXAllUnReadCountModel * unReadMsgModel;
}

@property (weak, nonatomic) IBOutlet UICollectionView *toolsMenuCCView;

@end

@implementation HToolsMenuTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    arrImageNames = @[@"h_tool_yytx-blue",@"h_tool_hyd",@"h_tool_scyp",@"h_tool_cf",@"h_tool_yy",@"h_tool_xjq"];
    arrTitles = @[@"用药提醒",@"化验单分析",@"收藏",@"处方",@"预约",@"现金券"];
    [_toolsMenuCCView setScrollEnabled:false];
    [_toolsMenuCCView setBackgroundColor:ZXWHITE_COLOR];
    [_toolsMenuCCView registerNib:[UINib nibWithNibName:@"HToolsMenuCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HToolsMenuCollectionCell"];
    //
    UIView * hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 126, ZX_BOUNDS_WIDTH, 0.5)];
    [hLine setBackgroundColor:[UIColor zx_separatorColor]];
    [_toolsMenuCCView addSubview:hLine];
    
    UIView * vLine1 = [[UIView alloc] initWithFrame:CGRectMake(ZX_BOUNDS_WIDTH / 3 -0.5, 0, 0.5, 252)];
    [vLine1 setBackgroundColor:[UIColor zx_separatorColor]];
    [_toolsMenuCCView addSubview:vLine1];
    
    UIView * vLine2 = [[UIView alloc] initWithFrame:CGRectMake(ZX_BOUNDS_WIDTH / 3 * 2 -0.5, 0, 0.5, 252)];
    [vLine2 setBackgroundColor:[UIColor zx_separatorColor]];
    [_toolsMenuCCView addSubview:vLine2];
    [ZXNotificationCenter addObserver:self selector:@selector(updateUnReadCount:) name:ZXNOTICE_UPDATE_UNREAD_MSG_COUNT object:nil];
}


- (void)updateUnReadCount:(NSNotification *)notice{
    if ([notice.object isKindOfClass:[ZXAllUnReadCountModel class]]) {
        unReadMsgModel = (ZXAllUnReadCountModel *)notice.object;
        [self.toolsMenuCCView reloadData];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HToolsMenuCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HToolsMenuCollectionCell" forIndexPath:indexPath];
    NSInteger index = indexPath.section * 3 + indexPath.row;
    [cell setTitle:arrTitles[index] image:arrImageNames[index]];
    [cell setUNReadMessageCount:0];
    if (index == 5) {//现金券
        if (unReadMsgModel) {
            [cell setUNReadMessageCount:unReadMsgModel.couponUnRead];
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(floor((ZX_BOUNDS_WIDTH - 2) / 3.0), 125);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.section * 3 + indexPath.row;
    if (_delegate && [_delegate respondsToSelector:@selector(toolsMenuActionsWithIndex:)]) {
        [_delegate toolsMenuActionsWithIndex:index];
    }
}

@end
