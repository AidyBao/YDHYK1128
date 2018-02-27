//
//  HDiscoverTableViewDataSource.m
//  YDHYK
//
//  Created by JuanFelix on 01/12/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "HDiscoverTableViewDataSource.h"
#import "ZXDiscoverModel.h"
#import "HDiscoverCellType1.h"
#import "HDiscoverCellType2.h"

@implementation HDiscoverTableViewDataSource


#pragma mark -  TableView DataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_lists && _lists.count) {
        return _lists.count ;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZXDiscoverModel * model = [_lists objectAtIndex:indexPath.section];//% _lists.count
    if ([model.homeIconType integerValue] == 1) {//小图
        HDiscoverCellType1 * cell = [tableView dequeueReusableCellWithIdentifier:HDICOVER_CELLTYPE1 forIndexPath:indexPath];
        [cell reloadData:model];
        return cell;
    }else{//大图
        HDiscoverCellType1 * cell = [tableView dequeueReusableCellWithIdentifier:HDICOVER_CELLTYPE2 forIndexPath:indexPath];
        [cell reloadData:model];
        return cell;
    }
    return nil;
}

@end
