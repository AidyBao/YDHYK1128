//
//  HTextDataSource.m
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HTextTableDataSource.h"
#import "HTextTableCell.h"
#import "HOrderMenuTableCell.h"
#import "HToolsMenuTableCell.h"

@implementation HTextTableDataSource


#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HTextTableCell * cell = [tableView dequeueReusableCellWithIdentifier:HTEXTCELL_CELLID forIndexPath:indexPath];
            [cell setTitle:@"我的订单" extralInfo:@"查看全部订单" showArrow:true];
            return cell;
        }else{
            HOrderMenuTableCell * cell = [tableView dequeueReusableCellWithIdentifier:HORDERMENU_CELLID forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            HTextTableCell * cell = [tableView dequeueReusableCellWithIdentifier:HTEXTCELL_CELLID forIndexPath:indexPath];
            [cell setTitle:@"我的工具" extralInfo:nil showArrow:false];
            return cell;
        }else{
            HToolsMenuTableCell * cell = [tableView dequeueReusableCellWithIdentifier:HTOOLSMENU_CELLID forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        }
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

#pragma mark - 
- (void)orderMenuActionsWithIndex:(NSInteger)index{
    if (_delegate && [_delegate respondsToSelector:@selector(orderMenuActionsWithIndex:)]) {
        [_delegate orderMenuActionsWithIndex:index];
    }
}

- (void)toolsMenuActionsWithIndex:(NSInteger)index{
    if (_delegate && [_delegate respondsToSelector:@selector(toolsMenuActionsWithIndex:)]) {
        [_delegate toolsMenuActionsWithIndex:index];
    }
}


@end
