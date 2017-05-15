//
//  CustomTableViewCell.m
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell


-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.enterBtn.layer.borderColor = [UIColor blueColor].CGColor;
    self.enterBtn.layer.borderWidth = 0.5;
    self.enterBtn.layer.cornerRadius = 5;
    
}


-(void)setCellModel:(TableViewCellModel *)cellModel{
    _cellModel = cellModel;
    self.shopName.text = cellModel.shopName;
    self.shopSolgan.text = cellModel.solgan;
    [self.distance setTitle:cellModel.showDistance forState:UIControlStateNormal];
    [self.phoneBtn setTitle:cellModel.phone forState:UIControlStateNormal];
}


//进店逛逛点击事件
- (IBAction)enterBtnPressed:(UIButton *)sender {
    

    NSLog(@"aaa==%@",self.cellModel.shopName);
}

@end
