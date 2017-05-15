//
//  TableViewCellModel.m
//  MVVMDemo
//
//  Created by 张琳 on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TableViewCellModel.h"

@implementation TableViewCellModel
-(id)initWithCustomModel:(CustomModel *)model
{
    self = [super init];
    if(self){
        self.shopName = model.shopName;
        self.url = model.url;
        self.solgan = model.solgan;
        self.phone = model.phone;
        
        if(model.distance<1000){
            self.showDistance = [NSString stringWithFormat:@"%.2fm",model.distance];
        }else{
            self.showDistance = [NSString stringWithFormat:@"%.2fkm",model.distance/1000.0];
        }
    }
    return self;
}
@end
