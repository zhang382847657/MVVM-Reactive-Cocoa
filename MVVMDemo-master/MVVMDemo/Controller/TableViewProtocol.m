//
//  TableViewProtocol.m
//  MVVMDemo
//
//  Created by 张琳 on 2017/5/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TableViewProtocol.h"

@implementation TableViewProtocol

-(id)initWithTableViewModel:(TableViewModel *)tableViewModel
{
    self = [super init];
    if (self) {
        self.tableViewModel = tableViewModel;
    }
    return self;
}

#pragma TableView-DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewModel.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier= @"tg";
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {//如何让创建的cell加个戳
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:nil options:nil]firstObject];
    }
    cell.cellModel = self.tableViewModel.array[indexPath.row];
    return cell;
}

#pragma TableView-Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedCellBlock){
        self.selectedCellBlock(indexPath);
    }
}


-(void)returnSelectedCell:(SelectedCellBlock)block{
    self.selectedCellBlock = block;
}
@end
