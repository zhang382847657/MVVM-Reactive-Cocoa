//
//  TableViewModel.m
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TableViewModel.h"
#import "TableViewCellModel.h"


@interface TableViewModel ()

@end

@implementation TableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)headerRefreshRequestWithCallback:(callback)callback
{
    __weak typeof(self) weakSelf = self;
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            // 主线程刷新视图
            __strong typeof(self) strongSelf = weakSelf;
            callback([strongSelf loadNetData]);
        });
    });
}

- (void )footerRefreshRequestWithCallback:(callback)callback
{
    __weak typeof(self) weakSelf = self;
        //  后台执行：
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(2);
            dispatch_async(dispatch_get_main_queue(), ^{
                // 主线程刷新视图
                __strong typeof(self) strongSelf = weakSelf;
                callback([strongSelf loadNetData]);
            });
        });
}

//模拟数据
-(NSMutableArray *)loadNetData{
    NSMutableArray *arr=[NSMutableArray array];
    for (int i=0; i<16; i++) {
        int x = arc4random() % 100;
        int y = arc4random() % 2000;
        CustomModel *model=[[CustomModel alloc] init];
        model.shopName = [NSString stringWithFormat:@"门店%d",x];
        model.solgan = @"全球领先的家庭服务提供商";
        model.phone = [NSString stringWithFormat:@"025-%d",x];
        model.distance = x + y;
        TableViewCellModel *vm = [[TableViewCellModel alloc]initWithCustomModel:model];
        [arr addObject:vm];
    }
    return arr;
}


@end
