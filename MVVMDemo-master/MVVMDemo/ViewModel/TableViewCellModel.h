//
//  TableViewCellModel.h
//  MVVMDemo
//
//  Created by 张琳 on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomModel.h"

@interface TableViewCellModel : NSObject
@property (nonatomic, copy) NSString *shopName;//门店名称
@property (nonatomic, copy) NSString *url;//图片url
@property (nonatomic, copy) NSString *solgan;//标语
@property (nonatomic, copy) NSString *phone;//手机号
@property (nonatomic, copy) NSString *showDistance;//距离

-(id)initWithCustomModel:(CustomModel *)model;
@end
