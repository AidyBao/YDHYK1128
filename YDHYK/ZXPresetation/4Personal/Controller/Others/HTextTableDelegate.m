//
//  HTextTableDelegate.m
//  YDHYK
//
//  Created by JuanFelix on 05/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HTextTableDelegate.h"

@implementation HTextTableDelegate


#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//订单
        if (indexPath.row == 0) {//我的订单
            return 44;
        }
        return 84;//订单分类子菜单
    }else{
        if (indexPath.row == 0) {//我的工具
            return 44;
        }
        return 251;//工具子菜单
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor zx_assistColor]];
    return view;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {//全部订单
        if (_delegate && [_delegate respondsToSelector:@selector(orderMenuActionsWithIndex:)]) {
            [_delegate orderMenuActionsWithIndex:0];
        }
    }
}

@end
