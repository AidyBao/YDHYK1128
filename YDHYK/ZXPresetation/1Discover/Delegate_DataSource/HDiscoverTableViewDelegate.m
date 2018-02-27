//
//  HDiscoverTableViewDelegate.m
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HDiscoverTableViewDelegate.h"
#import "ZXDiscoverModel.h"
#import "HDiscoverViewController.h"
#import "ZXDiscoverViewModel.h"

@implementation HDiscoverTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXDiscoverModel * model = [_lists objectAtIndex:indexPath.section];//% _lists.count
    if (model) {
        [ZXHUD MBShowLoadingInView:[ZXRootViewControllers window] text:ZX_LOADING_TEXT delay:0];
        [ZXDiscoverViewModel loadDiscoverDetailByPromotionId:model.promotionId memberId:[[YDAPPManager shareManager] getMemberId] token:[[YDAPPManager shareManager] getUserToken] zxCompletion:^(ZXDiscoverModel *model, NSInteger status, BOOL success, NSString *errorMsg) {
            [ZXHUD MBHideForView:[ZXRootViewControllers window] animate:true];
            if (status == ZXAPI_SUCCESS) {
                ZXHTMLViewViewController * htmlView = [[ZXHTMLViewViewController alloc] init];
                htmlView.title = model.groupName;
                ZXHTMLContentModel * htmlModel = [[ZXHTMLContentModel alloc] init];
                htmlModel.title       = model.title;
                htmlModel.content     = model.content;
                htmlModel.publishDate = model.publishDate;
                htmlView.htmlContentModel = htmlModel;
                [_discoverVC.navigationController pushViewController:htmlView animated:true];
            }else{
                [ZXHUD MBShowFailureInView:[ZXRootViewControllers window] text:errorMsg delay:1.2];
            }
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXDiscoverModel * model = [_lists objectAtIndex:indexPath.section];//% _lists.count
    if ([model.homeIconType integerValue] == 1) {//小图
        return 110;
    }
    return 239;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    ZXDiscoverModel * model = [_lists objectAtIndex:section];//% _lists.count
    if (section == 0) {//第一张
        return CGFLOAT_MIN;
    }else{
        ZXDiscoverModel * preModel = [_lists objectAtIndex:section - 1];
        if ([preModel.homeIconType integerValue] != [model.homeIconType integerValue]) {//上下两张不一样
            return 10;
        }else{//上下两张一样
            if ([preModel.homeIconType integerValue] != 1) {//大图 间隔10
                return 10;
            }else{//小图 无间隔
                return CGFLOAT_MIN;
            }
        }
    }
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor zx_assistColor]];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor zx_assistColor]];
    return view;
}
#pragma mark -- ScollViewDelegate
//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_discoverVC zx_scrollViewWillBeginDragging:scrollView];
}
//结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_discoverVC zx_scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_discoverVC zx_scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_discoverVC zx_scrollViewDidScroll:scrollView];
}


@end
