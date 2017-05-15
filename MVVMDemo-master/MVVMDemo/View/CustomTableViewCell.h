//
//  CustomTableViewCell.h
//  MVVMDemo
//
//  Created by coderyi on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TableViewCellModel.h"

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *shopSolgan;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *distance;
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (nonatomic, strong) TableViewCellModel *cellModel;

@end
