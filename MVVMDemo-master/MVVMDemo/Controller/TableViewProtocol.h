//
//  TableViewProtocol.h
//  MVVMDemo
//
//  Created by 张琳 on 2017/5/5.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TableViewModel.h"
#import "CustomTableViewCell.h"

typedef void(^SelectedCellBlock)(NSIndexPath *indexPath);

@interface TableViewProtocol : NSObject<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) TableViewModel *tableViewModel;
@property (nonatomic, copy) SelectedCellBlock selectedCellBlock;

-(id)initWithTableViewModel:(TableViewModel *)tableViewModel;

//选中行的回调
-(void)returnSelectedCell:(SelectedCellBlock)block;
@end
